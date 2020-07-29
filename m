Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497D12324EF
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 20:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgG2SzA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 14:55:00 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10354 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Sy7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jul 2020 14:54:59 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f21c5f50000>; Wed, 29 Jul 2020 11:54:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 29 Jul 2020 11:54:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 29 Jul 2020 11:54:58 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jul
 2020 18:54:57 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 29 Jul 2020 18:54:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTp1ekpaVruKh+ALag9re64rykpWvadc0TKiZj88i5IYcUECdUNkZglhc8+W8057nmdb0mfaPEfjQLU4+wsNHjnDkAVQbznsq5xlcHDOulaJ5nPcJ2BoJ9QPIdQu7ur3C0czOyMLc3umxnKyNyNmUweZoRBM8e31vBrnWPM/Dm/opJbhLYr3TP+dR3XVxTd/opKMnkQm2YLzd+hKnIhkgTJr2NdOc/WbdnRqmlayjy5HsqIUquhpBakFYEWITlRa7U0lLZyvH19+OzlMWzzbrHZ1MYXtcPvhqnWlCuZZDhI2Vu8qgsN/dS0eu6sKZsIIFPbqkAKhmFOL5PIxzKbmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS34gvQr17m7kx/2z0AP3X41IWxj//Yju8APP3G7Yas=;
 b=KtsDh3xPLZSznIv99fItC6sPEO+4bie9oWt/vWVlT4z1PDVRuuuO9ThUpd4v4VrsBUECS/XQLYtxfMZTgXHshoSbQ2FLjelnToOBRGCozRwC2hingO8j+TNGz5ly7ODY66AOn6/hSaP//XAqQIXH9u/c7nHVR/zZcc7C2WQCKz7s0nQ6nD24Ow7dGnCiNR4gv7uMiO5E0ywXka9jhOs7es5l5L3xiVOCvkaUig/NCRJdhd8sadDgqU74j3JOGu2U2XRznzaYS9CVbCgydzyEGDusvRuTFnGCcHEeeT55g4gHGk0A3MZCAr9I2pqcp9aHiKKoRqS3oO0b1vAIOlHulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Wed, 29 Jul
 2020 18:54:56 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 18:54:56 +0000
Date:   Wed, 29 Jul 2020 15:54:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/rdmavt: Fix RQ counting issues causing use of
 an invalid RWQE
Message-ID: <20200729185453.GA278576@nvidia.com>
References: <20200728183848.22226.29132.stgit@awfm-01.aw.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200728183848.22226.29132.stgit@awfm-01.aw.intel.com>
X-ClientProxiedBy: MN2PR15CA0038.namprd15.prod.outlook.com
 (2603:10b6:208:237::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0038.namprd15.prod.outlook.com (2603:10b6:208:237::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Wed, 29 Jul 2020 18:54:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k0rE5-001AUG-KL; Wed, 29 Jul 2020 15:54:53 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4fd54c9-2cef-41cd-1af5-08d833f0e1fe
X-MS-TrafficTypeDiagnostic: DM6PR12MB3308:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3308B0C410D1B098DEF5EA58C2700@DM6PR12MB3308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yxbFcjYpoL1Zfp2BpnhGsEty+sMPUzpgAmTNqD6qiGa0CXfa0BgRi+O/SPCd6ta5qTAiZ5SQPp3FxndsOVFfe2nzcc44wu5YHTfsk0n/W1Ryu6uDig0XMFvbkiKvAWiE70fnzxMJE0YsBHgBptTSG25+2c7D0/uSKFKouMX4fVkYbK0oveNidxzra3IVJABTpvKZeMEL5kxxKJ4KLyou2mP8VpanAcmymUiX+iY7DY5AoHUk2zUDjigzUzCMBWwwVyG0oeFdFK2QMGUxr64CCmDw7k8jVPkAkAe4rie+HRk6m3C6XDuXcAaAN5aqK3D8SFBmTl2jusFz7GtiZzDRRsvqNQE7DSzUzrDSS3oBdGfcOQwMxo5QTTF/RDVvzOpU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(66946007)(66556008)(66476007)(36756003)(5660300002)(8676002)(6916009)(33656002)(4326008)(9786002)(316002)(2616005)(8936002)(186003)(26005)(9746002)(426003)(478600001)(83380400001)(1076003)(86362001)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7SABIxR4bOKjc6FKT2Ozow3BeccEFTLEyN7ItgNvoACPztVfKUBK/T+WxwXPIrtzNtdg1JBYwz2uvqLu0outmZri1UcucJeSSWgFzlLeBiSom/Nfu3So0bGplvMCQMcKQ+dNY37DxqTEfQS1A5FfQEAXmd+mJo6T6cPxrSu7DgPkuEYOQ4KVQZ1pOsUib13AhLZz7ipD2lLXgaOyAU/ruFVW7pXkS0svEH+IPD2iU1YKwQcM8A17Jp8rGGb3rY/t1rH08ag7codEeHfPPHsuaQhEGEfQ9+L6hf0accG+1sVJN0McgSXSxnx6D3AQTKFvO1Sp85bY2C+GqANIA65CuHA01+1Sx6OooPhkKA36+SFyxfnw7RyzRYYcLS8/66nOH/tepOoApQd/vq7vc1/K1RTSOeqzEBm/X6MMOvs6de+3TeiToOdsz1y2nNw0OEZ3yCS9Cv8kfLQqYzjWZGeIVOoyNpP2s5zVUkQycLvEHISDyXj56/PnlUw8D1Kd4d5NJVLBBbFklHHcXBkHo487T78L4qU5ojqkDZdP8o/C15tFo5336p/8WI5jmEPwYlyjytXbE4UfaMr3AieDcHnRwWgUDnonHzoMXjPCJ8fXxpy4Eo8JPnnj0i4mQeqzXLMXpmsW/X/e/rFR6ofZlZsPxQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fd54c9-2cef-41cd-1af5-08d833f0e1fe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 18:54:55.7355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3D2uS4Ew1+IcW1SsLuC1LM/5+lnyXxzFEX2Tby/ynsife9r+BZAxrKetRlhyHdV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3308
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596048885; bh=dS34gvQr17m7kx/2z0AP3X41IWxj//Yju8APP3G7Yas=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=qxYTyy5yWT1ECe9jymGTVM9uZBj2GwxtCLqhtAewlO9z13GonqB0ij8wdAslB8eCj
         28QrbkUoVLbsny1RI/ysoRiv0/Jt/wg2trlIK/J3N/BUwPLzfTZ135GU9z9ySA9zEo
         KoTnCUU+lOFIj8JXgEkfyfeD71d+T5o5MLyuGMMhDO+6N2J+eXVFlLYDtSiA98aDxy
         HwSFqpxwWBadjWxw3VhN7f4FOjbJnVQNQd82cSEYFMU++thd9NlvYoDryFesgyVTKG
         airukuhQNilf/7GCf7vpJXIbiTaO1KfiH7kASEL4AvnrMfbVaPf2gx02dgyjyYwUUE
         kBiNeH8Oa/MjQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 28, 2020 at 02:38:48PM -0400, Mike Marciniszyn wrote:
> The lookaside count is improperly initialized to the size of the
> Receive Queue with the additional +1.  In the traces below, the
> RQ size is 384, so the count was set to 385.
> 
> The lookaside count is then rarely refreshed.  Note the high and
> incorrect count in the trace below:
> 
> rvt_get_rwqe: [hfi1_0] wqe ffffc900078e9008 wr_id 55c7206d75a0 qpn c
> 	qpt 2 pid 3018 num_sge 1 head 1 tail 0, count 385
> rvt_get_rwqe: (hfi1_rc_rcv+0x4eb/0x1480 [hfi1] <- rvt_get_rwqe) ret=0x1
> 
> The head,tail indicate there is only one RWQE posted although the count
> says 385 and we correctly return the element 0.
> 
> The next call to rvt_get_rwqe with the decremented count:
> 
> rvt_get_rwqe: [hfi1_0] wqe ffffc900078e9058 wr_id 0 qpn c
> 	qpt 2 pid 3018 num_sge 0 head 1 tail 1, count 384
> rvt_get_rwqe: (hfi1_rc_rcv+0x4eb/0x1480 [hfi1] <- rvt_get_rwqe) ret=0x1
> 
> Note that the RQ is empty (head == tail) yet we return the RWQE at tail 1,
> which is not valid because of the bogus high count.
> 
> Best case, the RWQE has never been posted and the rc logic sees an RWQE
> that is too small (all zeros) and puts the QP into an error state.
> 
> In the worst case, a server slow at posting receive buffers might fool
> rvt_get_rwqe() into fetching an old RWQE and corrupt memory.
> 
> Fix by deleting the faulty initialization code and creating an
> inline to fetch the posted count and convert all callers to use
> new inline.
> 
> Fixes: f592ae3c999f ("IB/rdmavt: Fracture single lock used for posting and processing RWQEs")
> Reported-by: Zhaojuan Guo <zguo@redhat.com>
> Cc: <stable@vger.kernel.org> # 5.4.x
> Reviewed-by: Kaike Wan <kaike.wan@intel.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Tested-by: Honggang Li <honli@redhat.com>
> ---
>  drivers/infiniband/sw/rdmavt/qp.c |   33 ++++-----------------------------
>  drivers/infiniband/sw/rdmavt/rc.c |    4 +---
>  include/rdma/rdmavt_qp.h          |   19 +++++++++++++++++++
>  3 files changed, 24 insertions(+), 32 deletions(-)

Applied to for-rc, thanks

Jason

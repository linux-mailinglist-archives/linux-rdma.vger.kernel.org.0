Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3874522CEE9
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 21:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGXTym (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 15:54:42 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:28906 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgGXTym (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Jul 2020 15:54:42 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1b3c7f0000>; Sat, 25 Jul 2020 03:54:39 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 24 Jul 2020 12:54:39 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 24 Jul 2020 12:54:39 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Jul
 2020 19:54:24 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 24 Jul 2020 19:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVtAroyONtVjx4EoniLGRqDErHIi+47qrUidXQb/rNTyXxgSEP0snEjF9gJfzi8PXeF2hWgrl/yudK10wEOBWLhGfnGHaD5hImhywW+r2MEmkscmdOtWEJ0x+7gddBYxGyKpErHK2vAAwirZXUn7Mqf5EdzouQI7VvPtHGumk5Bn4SP9VIayaftAk4Th3lkrlK2FawFPn3KPiki3XmuGF5a3H6mlH4lZvPlIj8Ha8+k5U83pb+o+k2MIAp5lDlE76xKsF56jgWDT26AautqhFmZAciDnK6ve15NrBwxWZsor3OB1LTTg1bwlIUX1h9hhHiNgo+jJbl6GUGWB3/bhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8kjQpd0oEJDqGDdaXHEvrTirheGzQBWke3PwOxT5aI=;
 b=iBLwEqfyU6lIJxTM+p4HVU8T+F05o9XdtPspgP5b+GMtB5mgGB6hk18oNNxn0IZ/hae+rBodkGHoCT8B/B6jOeuHHDz44zasgwG/Gz5dN6sZVsQA8ungjBBqqoEe53w6D5y7yE0wo0dBei/ljr87ZnHjPMZjgPfiCTk/6zVBQ21nh6pD2H5DOfNbuCHsqGka+RJPwQWXzjUkLh9/w4PgLFqvaiOcvqNjekj2I/Uu8UnZQpG7O7gSSzr2tbYMaK10A2iRzUf77ak/ioLYvc6qcGPfK/602HTN3Bm/FwngAcbr7ig1cVVcXn6t6seBChjru5ahpublgSRHtddC7bsmpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Fri, 24 Jul
 2020 19:54:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 19:54:21 +0000
Date:   Fri, 24 Jul 2020 16:54:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        kernel test robot <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 0/2] Fix warnings reported by kbuild
Message-ID: <20200724195420.GA3666137@nvidia.com>
References: <20200720175627.1273096-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200720175627.1273096-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:208:d4::48) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR04CA0035.namprd04.prod.outlook.com (2603:10b6:208:d4::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 19:54:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1jz3ls-00FNjt-9M; Fri, 24 Jul 2020 16:54:20 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a651234-646b-4b10-aa0d-08d8300b5bba
X-MS-TrafficTypeDiagnostic: DM6PR12MB4137:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4137DC531BE8633F9C8B8547C2770@DM6PR12MB4137.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Izm3rrKVNhhpROcxZ8rJQNi5L2tBdnfbIxCwwTN56bkXraP46s8eI7txVM0a0wq1RxyJv3RaB/2rHIYse+55ldSOe74YYeAwFXd2AfwBvmQn0AdcWNhkrBwxWGm8dlXGdfALv84WlmXR+jQ+L5p3eTHZAykwQ5wBTYAuh+Lp92cS5ZS8QJdL5NjMSCuIDUUra1miqHzanNCdk+fR/Pvx+bwgeIdrwisng6ISKsd5rfLbOhkPVyEZv0jjZktY95uA6c9fduLsw0cPAJOZWaELK7c7WJPWp2u2aQL4rqmpHuwDqOrJX9ITfQd0AFNdl5G+RnGphEtAZ0lIl07E9GNOpThnNaaTCKEsoEbxhaGDJHK+B0InGznf2R8be0cRxSKw9QLqPjlCgyAnsUGsMW6sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(8676002)(66556008)(966005)(316002)(2906002)(66946007)(66476007)(33656002)(54906003)(478600001)(186003)(5660300002)(36756003)(86362001)(426003)(9786002)(6916009)(8936002)(83380400001)(4326008)(9746002)(4744005)(1076003)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GE3JmRnRZDcCue/mwjziPRS8JXghaeil76B0I8SZl6CenuHsgAVf1aoWBNZmsO/Wda8jg5gKuLXk7iNn7KQjkNsKH1JVTwDhEGL/dC/Azfie/NePQy0lc9s/0U8e4wOdkasasLeT5XBH9Zh2mmdKhIPqoVP0lFD4QPzk+MA2lBrI5x9utvPTpwv1/jj62p36rdQlYP21+WSpkwDjQfalmhDusx4iv502ZTtX9ZXFpQ+NPjQY3LXmZ5HwzH9QmADjTlM+MlSR8+drOO0lpdM+/0a+R/sKJe3kqjRsEMB72ITY36Kan+wYSEHum0RAdVW8wOzAraXQl48dS3e1Cpjvmi+KqKkVoKPy2FZCO0dvwF4zWmpyakSGybLFtfPMPW/4AoFadKAszKXYsuBf7O2gkExTrEpYOFsIllO2d2TnvwMwXn8+Ljqoaz2LpXleWKl1wJjYQq1455c1ePed5cWA+47bHG+YH0mg5J+/ADvEscg=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a651234-646b-4b10-aa0d-08d8300b5bba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 19:54:21.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPJV+DlE93TuzTiBPjReQehk+d52JvNK5ZESfXoxvnCpM3lY28raH56kWTQcDXsl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595620479; bh=/8kjQpd0oEJDqGDdaXHEvrTirheGzQBWke3PwOxT5aI=;
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
        b=lQ4qM4NyYmFTmwB6grvgBqqB5U94p7U6MNQ+PMS5FAQiuCTz9YzlI7j7beGCPOLsd
         +pvFkeB7fCFewpX9gTekVAN2l0v5IzsbGgEekB/uV8PYMs12I7e/mdN6toaZrbnwJR
         PSrHHGswaRheLbCCpROTtQsoBPJykO+hSrlgj2w9Yjt1QevPMs5bV/h5s2rBBZUOLC
         PxLb5BjDKlCRB7TwUq0UaEWSjII8gDPwGupC85p3e+4naZlrtXOtSPy7Pwe6x07kdo
         cy3MLTPU9b7v4YDUna0gQj0uWju5Sg0h+FEQrl/qPkZM6HxHvkwYuhAIOG0UbwNH4r
         53fi5Cy7YYVCQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 20, 2020 at 08:56:25PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog
> v1:
>  * Delete "pd" cleanup line
>  * Moved all cleaned feilds to be last in declaration list to improve
>   readability.
> v0:
> https://lore.kernel.org/lkml/20200719060319.77603-1-leon@kernel.org
> ------------------------------------------------------------------
> Hi,
> 
> There are two change as were reported by kbuild. They are not important
> enough to have Fixes line.
> 
> Thanks
> 
> Leon Romanovsky (2):
>   RDMA/uverbs: Remove redundant assignments
>   RDMA/uverbs: Silence shiftTooManyBitsSigned warning

Applied to for-next

Thanks,
Jason

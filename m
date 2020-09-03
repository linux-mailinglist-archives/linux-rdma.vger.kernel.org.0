Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0C125C36D
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 16:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgICOvi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 10:51:38 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10796 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbgICOPT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 10:15:19 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f50fa310000>; Thu, 03 Sep 2020 07:14:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 07:14:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 03 Sep 2020 07:14:57 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 14:14:53 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 14:14:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEP05ICPwGLUOdt7TkGz3lVaOQ5iKg/KgL/t3TyJB6crAWClXbaYFzt8KudZkscbeaYW4gqA3UGuBLopfhmJB/3GAh/slO6DFakT8/N3KUaQbrGVdOLuOrbBFR00kH34PM/kYJJO3t61SuoCioTzl1lz8tAQK2687NO2u/8DhbRON4ULaRlPRvTWHcOZbLyJ0aPUf+RCNiXL/TXSicfbxPh024HtDDh+IiOL1/HMg0vfvqJC5Xi7VN0zS47rZ2aRtevEKBMUMu3FQSpdlCrgyMXTkqmDVADMQ07WUNMzQbZO1+tuUur1Lr0WDqfXF6BuRzBINk8bB2s3EfbAfcHV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsCn3+NUHbCBlqxFHFBWBPuM5uvGyCJXEG/lb/yQjPs=;
 b=GfHprzSp2XR16YzhLqP7btl5zqmqr9TG3CrrkgOah7t1Vxw/bgk/zdBGJY0vTTUcIidT8I9rikSUEei0sF6ZEtxQQRQeAmhRZveg3OCofjeUjBvanUlZk8pFnjvazRsXTq2ayR3aW3FtL83hQ/oCOHjIqXRx+ZLPCznDYcy1ISJ5Rj1QuK3SMgBfHTAsZiru7wy3HUrs+ztVBDIemYQiLHP2W0L07YXSGV2F0pX3lxbvgbKuJWq4n1laQk8vbYzr8BMKREiGPjo7oHHafYyTCM7LMaGp5to9FpYZNzpvJ87+QGxnr5M5IPojFxTIU7lr9zuZZMsGdF0qIZrUeTge5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1145.namprd12.prod.outlook.com (2603:10b6:3:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 3 Sep
 2020 14:14:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 14:14:52 +0000
Date:   Thu, 3 Sep 2020 11:14:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
CC:     Adit Ranadive <aditr@vmware.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: Re: [PATCH 06/14] RDMA/umem: Split ib_umem_num_pages() into
 ib_umem_num_dma_blocks()
Message-ID: <20200903141450.GE1152540@nvidia.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <6-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <9DD61F30A802C4429A01CA4200E302A70107141188@ORSMSX101.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A70107141188@ORSMSX101.amr.corp.intel.com>
X-ClientProxiedBy: BL0PR01CA0010.prod.exchangelabs.com (2603:10b6:208:71::23)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR01CA0010.prod.exchangelabs.com (2603:10b6:208:71::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 14:14:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDq0o-006WBP-Vx; Thu, 03 Sep 2020 11:14:51 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e82dd78f-e249-4cb4-b9bc-08d85013b9ee
X-MS-TrafficTypeDiagnostic: DM5PR12MB1145:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1145F7D1DC9DCC1402385B69C22C0@DM5PR12MB1145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZC5rPfs8I+qTHej1BYep8CUyGZ0/cz6358s9crT2rK3ktw4TH2kX11I2B156VMG/qGHMAyF+WaAQFb5cJQYLeXu636O5Zv7aSA8VPjySW9QxLb1RmG4LY+MoEpNfyTuDcFBVZdhxFglD9mJUy8g8ZYFaorOibhw5HXe+et26tly79b4+N4+wqnWk1tiL/KHmoJMgGOQgbJuLsiyJR4I50KrjbEtEXVGJoACzOq3FHcdYqPKXSxkmrKkS9rySk4EiKumZxClTPCMou587JGCCBBjysnB2kngCellH3OfuET2b/XdvbXYVx11hBWsbatZEnFVPGWFHtIJ5gvgXxJ38tYDq3w2DqU99EFSQXhnoyPGEUqU5JFdzTgiP9lTHWSJH7x/dKk+n0+4iLYWTet1UFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(9746002)(8936002)(5660300002)(66946007)(6916009)(2616005)(316002)(36756003)(66476007)(66556008)(33656002)(2906002)(8676002)(86362001)(478600001)(186003)(83380400001)(9786002)(54906003)(426003)(4326008)(966005)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: whb0Gj1FT4kde4e+1YhPJFwdz/fwB2gVBaje7Z0cb1Zrhho3zZpJR1dCWjRAX2Gq+Er2HyyLBhYqiyOJQRzsM4zl2EDa0x1rSFu5zAdfZ+xw79ILkRz6AryomRUkVjcfiswHxwwRB3tuIOhgemj8pxffhokqB6AjZgndzR+Jfw2CcbmzU30AaqpiKItzrb6C6ioHOb3hYdqKivX+1s85Z45PgXpWA8uB8RNJAlIioNkL1W73Vz5SIDAGqgldr1WabwTU20CXw+wjkUxijFvvBHbbRESXA48bkI3jVLmrocJkXqfGCBmrOcJjrWLlqBxYctmX8/S5H3GcRQ9DHK63+Qq6bcTXOrI1K6334ZquzmZg8LHdF8hs1Y/Unnl0e7Ia3R/ftk1Lzxo+O+xIzdAhw1IlpqBh5RTswzzqcq92/8t6ZnZ2T+9baSjqwswWfHiQisqgnFZ4Xb0gf9GJhSsY0Odv2Mr8mLFb7Teu4av8nvdXnJZ9HWBAsXtpUhjJJGQsU2x7aWhE+Cor+QiCsQStDO8WClOfo682mJx+pEF1K2HYb2BmgOVPFtPTiwBJJGGT+P0w9YtcAVcsfXsBGTN6MXv7jq0zvYu4E+Prmcuj3xRDfnmqZjri6x1jYsynwaenwXY3SzDkMGTg+L5n1B+4Mg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e82dd78f-e249-4cb4-b9bc-08d85013b9ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 14:14:52.8684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T10y9uc1fuzg32NiqiLHwwfxC0bt0Yd+l7yo3kJsFE/NECb7zZ4lghPXRD43xLpy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599142449; bh=CsCn3+NUHbCBlqxFHFBWBPuM5uvGyCJXEG/lb/yQjPs=;
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
        b=MrVT7NRZUsmkubOR3cSBLionHofRGVEy+yqBaEkvbS5709EYFqhztXtHbnwbN3D4i
         noRUhx9DCaMOzJqJGAe2mkl08hBCsAJ2NYvMugoRUrkCEMBBX/+Ojj7gYFoIt7v1cT
         9HmFO40ULcI9Z6jQplNsMqk9kFOkOY8FLb13Rios0DQMSbmWZJ2EWnxJsU2B8GBKpq
         juN5UAB9y63FG9Y3YSarxuetHrjpEbYS2IWMfN3WclchHstwTCVoteqhBvhveLRO5p
         i+TNK1vnjMuZGaKisvQO4nfryO/ufCmue9qz+J44f5B9XgyXn1xZzwMdp3MNKu5W78
         KNV9lAAtSaJXg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 02:12:10PM +0000, Saleem, Shiraz wrote:
> > Subject: [PATCH 06/14] RDMA/umem: Split ib_umem_num_pages() into
> > ib_umem_num_dma_blocks()
> > 
> > ib_num_pages() should only be used by things working with the SGL in CPU
> > pages directly.
> > 
> > Drivers building DMA lists should use the new ib_num_dma_blocks() which returns
> > the number of blocks rdma_umem_for_each_block() will return.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >  drivers/infiniband/hw/cxgb4/mem.c            |  2 +-
> >  drivers/infiniband/hw/mlx5/mem.c             |  5 +++--
> >  drivers/infiniband/hw/mthca/mthca_provider.c |  2 +-
> > drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c |  2 +-
> >  include/rdma/ib_umem.h                       | 14 +++++++++++---
> >  5 files changed, 17 insertions(+), 8 deletions(-)
> > 
> 
> Perhaps the one in the bnxt_re too?
> 
> https://elixir.bootlin.com/linux/v5.9-rc3/source/drivers/infiniband/hw/bnxt_re/qplib_res.c#L94

Yes, that needs fixing, but it is not so easy. This patch is just for
the easy drivers..

Planning to do it separately as it is the 'easiest' of the remaining
'hard' conversions

Jason

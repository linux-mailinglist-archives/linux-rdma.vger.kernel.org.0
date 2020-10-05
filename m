Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F5A283C5A
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 18:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgJEQVB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 12:21:01 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:9850 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgJEQU6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Oct 2020 12:20:58 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7b47e80000>; Tue, 06 Oct 2020 00:20:56 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Oct
 2020 16:20:54 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 5 Oct 2020 16:20:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJWRLxG4/lVa68HibcE1Og7DRQFYs3i82+cWEU1X2WCaHc+cmhWlURByWK2MczYIFsoRPtHGkfNe/ttdiB7AiVyZcqmIvY/yhvix4b/VhVkeIec+NOn40l7ENoRzC+NE24uSGnorTU1pgt9VJ00qpcIrTo1PD5qi9Wrgqja502jwzJ4L/IGXrtjqOLR3U8J3BNmQlceFN0ZNLRFGLwy71Wa3R+Bn7mX/FZ3aGb7A7s5Z6docoT+DQZm4NQt6TB/E7XJJnoL72n65LDq6CR37Q+EP7fSMruini/43/GBUThhkpA4fkVB0ZN7uRZsGcImDQZPdtkFkAqTHbSCWhWs8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qzy8TD6m1sdCwFgDLTAiNlSZrnxxome2e3qtgoDC3rE=;
 b=BTZgoPGbYvBwqHQyjhPujf86OycN9SqciCRODME0p1BZinugraiV0x7bj5UpBMPmRS259Tde5FCRIDDIXXeEa5DtgGWqwBnm+Nl9fcVHZ1k5pNSsvTvnipCghJP07DlCFsxm1PJz0rRnKVAfJa35EIa7r/iGRpZY44ei12Xz+9dz7Rb5/By+8bJxt/NBn1j5p0T9cQSlteBF1ItWIJdfkNuclHxivnah9LW0VFI3gGtDQDMDSjo4MeCQMzheRNGr+ZBrGhimdD6Q+4PsXb0SdV18IijMLCllI5dvn0dn5BUYtjf3XK+y4pu1C4ZhsJKjShf+TLKboFrFnDQcdUsDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1243.namprd12.prod.outlook.com (2603:10b6:3:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Mon, 5 Oct
 2020 16:20:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 16:20:51 +0000
Date:   Mon, 5 Oct 2020 13:20:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        Lijun Ou <oulijun@huawei.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH 02/11] RDMA: Remove uverbs_ex_cmd_mask values that are
 linked to functions
Message-ID: <20201005162049.GZ816047@nvidia.com>
References: <2-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
 <52566b00-efd8-f797-abe8-2bdd11626213@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <52566b00-efd8-f797-abe8-2bdd11626213@amazon.com>
X-ClientProxiedBy: BL0PR0102CA0007.prod.exchangelabs.com
 (2603:10b6:207:18::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0007.prod.exchangelabs.com (2603:10b6:207:18::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Mon, 5 Oct 2020 16:20:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kPTEH-007h70-VS; Mon, 05 Oct 2020 13:20:49 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601914856; bh=Qzy8TD6m1sdCwFgDLTAiNlSZrnxxome2e3qtgoDC3rE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=TzrxlGJ/ktl+egCNmLFzGHHw9fWXsW70MRwWtk+QwEaY8H0J+gGs+H3Hn7Rry33R8
         PF4p0kMujF0DC3eugCsfjOvXqaVJylqtbTxPBfiBll/p7Fv1xOwD/D2LT3XyOP7W4Z
         d0E066rOSiDvnduN/XUILMUNKtsvsceNGKEGymLQbLqUhdyxU9fVpB17RySux2ycIY
         9yXhvqI+cPlizRE/B/1ygBkF91vC+GCRjJmfcfVgjBNKuimMFqOLs5/IpbzaeXoRrK
         AFlGs6D9xT2rM8zqd0mnTFzMXGQDYfdWgY3RiM9Dxv79ksbxHK2G42bmYEtdUxbKDE
         2zv46buBqr8Yw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 04, 2020 at 02:04:17PM +0300, Gal Pressman wrote:
> On 04/10/2020 2:20, Jason Gunthorpe wrote:
> > diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> > index 418d133a8fb080..2f3f9b87922e92 100644
> > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > @@ -3753,7 +3753,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
> >  			IB_USER_VERBS_EX_CMD_MODIFY_CQ,
> >  			ib_uverbs_ex_modify_cq,
> >  			UAPI_DEF_WRITE_I(struct ib_uverbs_ex_modify_cq),
> > -			UAPI_DEF_METHOD_NEEDS_FN(create_cq))),
> > +			UAPI_DEF_METHOD_NEEDS_FN(modify_cq))),
> 
> Good catch, but is it related to this patch?

Yes, previously the uverbs_ex_cmd_mask of
IB_USER_VERBS_EX_CMD_MODIFY_CQ prevented this typo from mattering as
no driver set both the bit and a null ops.

This patch has drivers setting null ops with the bit set, so it must
be fixed now.

Jason

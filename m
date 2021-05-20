Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84B738B230
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 16:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhETOuV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 10:50:21 -0400
Received: from mail-mw2nam10on2077.outbound.protection.outlook.com ([40.107.94.77]:52224
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230483AbhETOuU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 10:50:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7sjztByP3VNe2YMSpglj9gfvKSu7jCf8WLdI2VULfnk1YSBXKHtsANU+1NsqAuiDZzRcHb0Os5L6g9HCGrwU8EafBzgnUV48+AN7z+7FsIt5tFOz1ElG5hM3gb4ZBv/RSrj29RG0wuSCZz1cJw2hLOHWvXx/LMmlD9DfWtfuv7pzjacaiBKJH0Z3UIWDOJsgAEJ2WdlR8FDczShJLQI+jA1vtzAQaV+wKALDyYAKpMHSzCilS+eOVILU0euGU418ZPsiNFpTNYRNO9TIKemhl9qqYavT1nLbAJUWJDxb/9hJWb6IiP168kiPW9kVasWn5dfAl6t/mhhCBDY95Ug6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JdqJfEMF/wbaTNRhvukozdmnLz9VLq8Y7f0KlHaGno=;
 b=Wgel6qQoTfyhbsWvI345DLjdHJyecHC1QBM6NNViaQC3pza1gZWCP/XADmtX1ttiiJ+jD9rGq/6MwdC9vLc6aB18iOUcSEG9aMo0QwxeoVfqJC6UADYa+O0xrllaxpeQmsTXK20rt71iOm4UKOYDYr7wa+Q94ZoAYLCmkixmAwLG91agcCdNFlPjSs6ABOTnZ0OTVSEsfetQ/5oeGgZPHd6HsP52jb1XkQzbfx5UAEqNiM0XBg9Q7i5B3Kcclz8Q/keUBUUi+wYeL7PjoVOWb3xuYfjEg6WHZ9k4MV8FP08ixY53N3e+PBYTEBt0nm03/qA7smNnYnHhrUYdWVnGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JdqJfEMF/wbaTNRhvukozdmnLz9VLq8Y7f0KlHaGno=;
 b=nOq9VeyDI1c20M6IbKlcNevqItRoSaV9WUpU2thq3DIz/GeAaYAFUXRs4pwWMFvD/q9kZ+2B+faCWcjF51t6MPz5mxMuJiHUdOVwGOvRffwCmBUdywa5EtOcTrFgYtpGsNVANhUv/z2nKJG1fMwrnla3eoQvAIkqfqifiAIVvBCjK4gVZwCl/6FVtA5+aTMBGev61l/77TRKClioeA5fYJZ/JX3ABxlfti7/e34gZHOjXPLlBh9rJbCjwPdnc9jXeXNgBglpiPBmF4vf3AZ5uKJc59eGs0FXFDGNgBPQOnSzOwb5yNtRr9KpczCld07fBeroo/1qeoFWljokdewuUA==
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Thu, 20 May
 2021 14:48:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 14:48:58 +0000
Date:   Thu, 20 May 2021 11:48:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: Re: [PATCH 3/5] RDMA/srp: Apply the __packed attribute to members
 instead of structures
Message-ID: <20210520144856.GA2720258@nvidia.com>
References: <20210512032752.16611-1-bvanassche@acm.org>
 <20210512032752.16611-4-bvanassche@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512032752.16611-4-bvanassche@acm.org>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:208:120::42) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR10CA0029.namprd10.prod.outlook.com (2603:10b6:208:120::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Thu, 20 May 2021 14:48:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljjyq-00BPnj-OX; Thu, 20 May 2021 11:48:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f46a16e-5292-4cb1-f41b-08d91b9e65ed
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1753AC927526D9A924FB5A5BC22A9@DM5PR12MB1753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8uifl4LEhrgT/5ihhQjdzvgMmnQkwszOYHAcflSx85uydrBFzdONjhCVBXmXEABYK40nP8GN72p8c2zWVrdmb4ybvWlHY/vOEKoE9IJe7Ug60FhDolWz3voEeAwj+cz6ne4S8n3VBIec+aVTJ3MuSehYL7YlXpTEqx7T9WekjNF1GxQLgcb4DqBzceC7v34j3G/hcPOMW5+lKsWQdRNwEXob3RRjUcfGdGJNIefFnJP0jpTArNETvxWMqvOCZgh5+NhHURQoma7mK2sQ6qbg+b+kPvzY1L5arPyFzvUUDStLpFcXeXmhVRigg19IfBA4cQp1/ZLvHxQ1wzkBpwjhFj/v0Oit73DnNdIwEChkKpN0KCgWMw3KToCKd7v3vfJ8tsgAO2GutMYE+mcQ4+V99mC0PEELw+fHANaHKzMIGKXWWtJn5JLFYeZHyjNZwpHq7jZsuyoicKdoMf44eOQBEN38q0nv0LU3ZxrJy5e6amnaIXoSQmhehYMWJmv2qVarq3BL0vLrMaO0dODCuulRjaXoie+zssVeuxqrA+7q6wLk4XSUj/28OhQVL956FxoS3pFddJM9ZlBcSNSzm/GBe62cxlb7KjmGGuvXfrkdRHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(66476007)(186003)(86362001)(6916009)(9786002)(83380400001)(66556008)(33656002)(9746002)(66946007)(478600001)(8936002)(2616005)(54906003)(38100700002)(36756003)(8676002)(316002)(1076003)(5660300002)(426003)(2906002)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nPMA1quSOuB3DsjpUFrVlFk6ov4WWsF3wCqCoGB8Hy8fH5903ZsvQ+aBqbRM?=
 =?us-ascii?Q?2WBKzVyYdOzYcFoKSGOoySvfpV/ZE6ZUeKu12RFgwsOll7jya1NKCEPw8Gpn?=
 =?us-ascii?Q?LyULkcFMlgtQ4qLd/+jtiLZcix6if4/uw6PzuaB+olnkM16W0PcU5W8s4YvB?=
 =?us-ascii?Q?UlCpkMgsoKgSQzo2gq/i2DkcJ00D4zOUJXimfge61DiYerXtjKUli9jZjL7n?=
 =?us-ascii?Q?QuGuXusHBLTR4LDMyjcSmDynySjP2c3dPKJdk1285MOf6BT0Nd8w3a+D1Uwe?=
 =?us-ascii?Q?FFnaJmI2PqU8Eh+Y9TiyUvAYxnjMk7lDyOm0pl7kywmPp/eMzAXGBGGQbktF?=
 =?us-ascii?Q?UhQD6Bzprwms4moku2+Q15Sl3A5srmz7cFVtVc4/TbGG3ZhcoDT1Bgaifkby?=
 =?us-ascii?Q?BR6hIKtPIbB6A2aAK0m9bErOYy0BSSM34rGNIAabvlfAEceo4/CLpvlQ1Gpc?=
 =?us-ascii?Q?WSZZYr2E0yHir5lGVpppOYavv28biXfSa3oqhNRsmX3BOSGJ6LAQdLAcxCdq?=
 =?us-ascii?Q?WlCDPpHfhVRk2lIkP9L2RG/9MEdos6cp1sCAv1D5HhnJ263CL4xb57m5krxc?=
 =?us-ascii?Q?61MA06CPYPqbosKviye/zvb7GnOrqGKXSF62CUI7oEG3YV+3MkDIp+/JP8Da?=
 =?us-ascii?Q?h4mLfQuSrfYb3KL3aOwdd2BOmOn5Wex2ujA2nJa/FGlLGFz2U2el59CY8xQF?=
 =?us-ascii?Q?wuxR0Cu8lDsbmq64DQhbIrBkldi5jJc/TQK+xJWRs5erEUXGwLVHsbjBKmbK?=
 =?us-ascii?Q?g+sK0l6+nwyFJg9UyyAIImwZdbXQ4m2+fgT4t7GB298KkFGNKxd6wXkzMh2I?=
 =?us-ascii?Q?GCDSkeAixAWjUEqlCX27gkJ+v4zNMaNpdWgRMM/agMP5IiTwzf2MkC5Ax0VR?=
 =?us-ascii?Q?HFJ3MTBARBv37Z/qnP5H5A0DPGaaNn+zaiWsU7Jd6a4PI0gpD1CG7OFKRUEi?=
 =?us-ascii?Q?uyEBZjyn2gJ5FuUkhIIGmpmHuozu+TLTnLm1K6/0CmU1no3Snyu5Vr73OKhz?=
 =?us-ascii?Q?W+nwqW4p2FuNRtsLErr9kcusVU8pIxC2QeYUILf3vGFJmTpDMhMJ4VQTwj13?=
 =?us-ascii?Q?UWKcl+4N33o2HM+YXnYDbsKxG2hxqZjD7mqEn93dAs7wrTp18kcYFTAo8qpC?=
 =?us-ascii?Q?yNom8yqpWc/yvZDgLGoXPcAEnol60GSMTpZxKMxZEmXX68T3LvV36rdsXoND?=
 =?us-ascii?Q?UqBRQyoLJdA/GX1SNc84OoHpFN6xv19PsPsdTSZot83tHIPT8dB8UjcPjl7p?=
 =?us-ascii?Q?2hZ5YzQSdr40wbQqct6w2oaKNEFDFISPahIebPv1AGZBQUgW5tYmaRGa1KoO?=
 =?us-ascii?Q?LXmWWxYVSzBB8s1kp64PNJGy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f46a16e-5292-4cb1-f41b-08d91b9e65ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 14:48:58.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BneszMvWASC3ormnKG/evuiSjHhike6zYQ1uJNfy4tu+vQlmy3DutxTAlYLDcIR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1753
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 11, 2021 at 08:27:50PM -0700, Bart Van Assche wrote:
> @@ -107,10 +107,10 @@ struct srp_direct_buf {
>   * having the 20-byte structure padded to 24 bytes on 64-bit architectures.
>   */
>  struct srp_indirect_buf {
> -	struct srp_direct_buf	table_desc;
> +	struct srp_direct_buf	table_desc __packed;
>  	__be32			len;
> -	struct srp_direct_buf	desc_list[];
> -} __attribute__((packed));
> +	struct srp_direct_buf	desc_list[] __packed;
> +};
>  
>  /* Immediate data buffer descriptor as defined in SRP2. */
>  struct srp_imm_buf {
> @@ -175,13 +175,13 @@ struct srp_login_rsp {
>  	u8	opcode;
>  	u8	reserved1[3];
>  	__be32	req_lim_delta;
> -	u64	tag;
> +	u64	tag __packed;

What you really want is just something like this:

typedef u64 __attribute__((aligned(4))) compat_u64;

And then use that every place you have the u64 and forget about packed
entirely.

Except for a couple exceptions IBA mads are always aligned to 4 bytes,
only the 64 bit quantities are unaligned.

But really this whole thing should be replaced with the IBA_FIELD
macros like include/rdma/ibta_vol1_c12.h demos.

Then it would be sparse safe and obviously endian correct as well.

I suppose you are respinning this due to the other comments?

Jason

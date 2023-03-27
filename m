Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEBE6CA4F7
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Mar 2023 14:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjC0M5W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Mar 2023 08:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjC0M5P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Mar 2023 08:57:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::60c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466B010C4
        for <linux-rdma@vger.kernel.org>; Mon, 27 Mar 2023 05:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUfa8LduKQc1T2qn3JBkKgQ5GeG+mGs2E6msfioZi1fyyC+SNx5FF5Lkurd/RQqz6yIWqMIFGJxEgSIxzmYAkHjw+Zkb61ECUN9eaBs10R53SNCM9WE2w+3kUAdjgTiX0D+WA6N2bE+VFch8g9qKw6h53AA4HNGo9c7p89+Wc0pOSdD0MDY+T4Uaj9dGY9WPdgVA4TGyWMfW+hNj9h8qhdktqLA3tFf00xaSOO3J5TDGoMezmxj7hjbrmVrOMPj5vwO16GEMLqDbfCm9wSYIX9lqJQi9YFKbrNB1WrFDRwOUihGRxIHTs6a929a73KAwm4PwCsjiJWmP9vdwmZSqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9lqyjDeYgk5Rn//syr89bt0JlEtHpZdBAIA2MScfL8=;
 b=g0wP/fm+mKOR/x2GcqCAjkDeFrjSsz7Qqmvt1nM4CXCMCedIw99k/haVhgG8N6R9/lUUfvCFm7MBvVNUBg5qmvZkyP9Y1DpiPiqT4IdP5GQONyS/1i77RQrpjnCuy/bp4akMn1PbVoHdvcKHFaFC5B+azpHlavoxJASi21Zi+XGMru6Ipx7jUELMrFVE+PrxzChI4NkxuUhev1KwmNgxS2JyOrcIw8VpNqIpbUe8kM3DU3Pje1CXYGgZwKb0yH8RrcAESBcrsEyJ4JDahXtUGmCcNVx1fBG4TDps1lag/ANQHBULEFVs/UbQsOQBubvhN5SiYp9WSQcNsaMAbDplvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9lqyjDeYgk5Rn//syr89bt0JlEtHpZdBAIA2MScfL8=;
 b=cyvCvup5p3IaptBHxqpxnMCjqY/psL2NGhBTT+fyZD2/ECLRLX0TEzF/rnUZaop6zq3DqNH4d93nJ8mBfDPWR2yLa+Z9nZyhDyR4gD9w2nJ4DqyaL3VAuVEmjfHfRldrNn5AigIWGIsdUKYvXdsxQTwcvCrb5ZV3RbIczR1+NzG+IrmaKEqSeGubG8qk4C4H25uwlwRyd8UbW7vMA4Ht4FaNbfq45b1vEBPT6E8XM4e8wHQatm0cGt8LktM828vpucwtu99sHyZljGN4APtjafYZJadYuvw6fAkrimk3SFWfe2lVY7KW1nX/ah1ZMfRpkxnYodDB2nY2Z6TyY6rFqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 12:56:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 12:56:00 +0000
Date:   Mon, 27 Mar 2023 09:55:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH for-next 3/3] libhns: Add support for SVE Direct WQE
 function
Message-ID: <ZCGSXzD8LJqsXHTF@nvidia.com>
References: <20230225100253.3993383-1-xuhaoyue1@hisilicon.com>
 <20230225100253.3993383-4-xuhaoyue1@hisilicon.com>
 <ZBtQ1/3WjWNXAT/b@nvidia.com>
 <53ff5576-3469-1264-aab9-6eed7956238c@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53ff5576-3469-1264-aab9-6eed7956238c@hisilicon.com>
X-ClientProxiedBy: YT3PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: 99266f42-a601-41c9-8822-08db2ec29dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCb3p7/x2inJ6VkWW/Y39d+o9NA4zxU8iiZ6vQaRm/LDv1S08aIQDn/hpRCnPW6kwArbRisBV6GvPpc8yOSwWPW9dxeWdgOapp7C6rh6cYeq0FYu+lDsGjai956WEtdRXCZ+lNVgg6vtpgptw8x+hjsfJyu6I32GjoXB8Yl/4zZBH5+AWd9B9TIW7zP+1rvUo4tHB0IT9uO31OX4htT//nZ1Xm0a3l1pYeii5GBGfrSj3MVkP+Yr6hpC6iQbTCHTxktrYTj9dqMfsc7nEXy5H+VtIshgjaUoUtDpWqsuAB/Jqt5YNzYzowzfoIT4jDmDoGdsYtVjwGaKV/csLur3e1FHCjL2u71P/xVE46fpgMRAh+WAghkydPYUgGWQZSZpdA/f0krfUafK+0a8ajFA9BI3ufP00fToiSjnTayYkyndeT4ibWbplSuMWH/QzOaksbgiS7Z9R1o9TWq9wE6yNyUQb5OYbK3HFJPuwJuufcaxGdQxqZ9kG1sZ+jQKppmAOiVXX9wHc+ByTFabCsV0jzGBE4B66+/WNf75MQADoFqkPCH3QP561fNo6L3d+PbV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199021)(478600001)(6506007)(6512007)(316002)(6486002)(66476007)(66946007)(66556008)(8676002)(6916009)(4326008)(41300700001)(26005)(2616005)(8936002)(186003)(2906002)(83380400001)(36756003)(5660300002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HWc8y6PMiHuF6Lu3EkKzmxtUnB+CdRyAVPSVas9vJ75HGVkoVTEu3Xxx4DPY?=
 =?us-ascii?Q?421o80wZISsUsyRfpxfAa3rwNCQG6U20Hej9Yg6D9Io0Sjsm0RA2oP3Hf9zv?=
 =?us-ascii?Q?nLYzWMjDXW7S9Bz8Dwthz0bfZGdLAr3S+ji5AtVkv1XeM8X6RP8FxyK3JkMH?=
 =?us-ascii?Q?TPPby/gei3WDJbzqgpIBf2e+q3h8kMYcdO33Q7sYsffoK3KBbriYcGOjdZl2?=
 =?us-ascii?Q?IJ1G8OH8mONMXpBIsmLEQGDQNKu7omtiznXTtRevaZGdFNYqwzmZi95fRbTd?=
 =?us-ascii?Q?sisAkziArDNHdvielDXNjudVESmE8idqlmVhhMbtw9p1AKC2NdJbHwzUp5HM?=
 =?us-ascii?Q?NIswyFY+5ZCGPZa97RVvEAP6HcP+cVPuT6G72+cgrl+dmWhdOL5O07S7Xm08?=
 =?us-ascii?Q?wMu3Fg0g90bPxbnrr64Z97Z44x8TS8FHxAFrulC9UD5QOBfpJkFAeGZhXOqd?=
 =?us-ascii?Q?pJNTKHS9grRpjx67biLYWKNcpKtF2k//m/PCvgzMHCm66nBCJhKtn10BIbeV?=
 =?us-ascii?Q?KjHp08NNbtO+FKv1ehBeDwbv904aO9VlvV/7EH9Sr6Rmqu9UOoYy7Co6S9GG?=
 =?us-ascii?Q?45fAE8qOMgV3+HjHdw+au0oII9hIoZNikHyay43F9CGqjDkg86GMKVuL7Elk?=
 =?us-ascii?Q?x7HQ8lRigwM/XL+xDirIXVH6T9vF6NnGyd/BVw64czUEo+I1Rrd5Kjvz2Qns?=
 =?us-ascii?Q?jKDlqAQHnX9tdr45qTwQ5cA/t1zJCIBaVH5nKXYj+MC11owEiYicO2I4u9bl?=
 =?us-ascii?Q?yCwBRtupTKs8rn+I95JypxJm/Hkmo6UgkmAVnTBQ2ht64P8RUX5UqQ74lb8R?=
 =?us-ascii?Q?ZpVN7VHf4Y7j3whdKVI3+wJxGIFcRFxsuJG3QSyidN/uZEXv7U6FtMuS5PAR?=
 =?us-ascii?Q?ov/elwjHNp4GZqIQvDWFPF9XoAHOBs4bfnAH/a5S5kyZYy9sp9EDBnaiBzLY?=
 =?us-ascii?Q?IXTz2hwmDVQR6eHEFa8ghtgBTOewrU+oEgK23sWRYUw4vk/87pBSuVxP4BNZ?=
 =?us-ascii?Q?grXzDzTuqqltl4DCoCOWPz4/DRo7K4zYmKYS2obqO+loujfHorYJaLA0ufCr?=
 =?us-ascii?Q?ohJ/Bu8fQkBwqiHGhpIveHggaxrvjWrzzvxTStGZN7Q97ucKiqdV5NBRgFwI?=
 =?us-ascii?Q?twExHRcmtXixyJGzfQQlF5ahhHmpL1OxPXs1RRanvfU/R6hMF0HKmBcJiNyd?=
 =?us-ascii?Q?R6vxlJ5cI4Lj1EhgwnfWNEDLd7b2I1GqfC/bi4KIjRHrbvf+Uspq41nERbtr?=
 =?us-ascii?Q?2MzwrUmgPyd/boCmFx9MRHNOK6WJOG9JaIoskulpB9Vb8dzpywhCaZGkUA6f?=
 =?us-ascii?Q?QhN+r/gedFygsA3L/bTCyur4A5/bQHZ9H8pkaW8kPP2EwuSoPPFVPnf4tizH?=
 =?us-ascii?Q?wlmT9ul0MCgxxVywZ4NBgWc8dqe2dwRd7raDDW3fBdbXMPmzrst+3BNcYa3A?=
 =?us-ascii?Q?4Iw+UZ+wSrwjn1k7T2viNimNEBdGI4HVL9/F23dpdoI3FcBzF8RzlsVLKraV?=
 =?us-ascii?Q?3TGlat7r01O1+ctR3COU5OmKktF5te/eXgvQQEIBZhRs8emE1wz95uAQ+lIf?=
 =?us-ascii?Q?2AvAS/jHE3DGitn7/P4v1IrT9qhhMayRqZQBPsfe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99266f42-a601-41c9-8822-08db2ec29dc2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 12:56:00.9143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gd5Sgr/5vzAtHmng83V8GIe8QnrhZLGxKiymBBtzngaW8JwIyLB4dMa1va3dExRq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 27, 2023 at 08:53:35PM +0800, xuhaoyue (A) wrote:

> >>  static void hns_roce_write512(uint64_t *dest, uint64_t *val)
> >>  {
> >>  	mmio_memcpy_x64(dest, val, sizeof(struct hns_roce_rc_sq_wqe));
> >> @@ -314,7 +319,10 @@ static void hns_roce_write_dwqe(struct hns_roce_qp *qp, void *wqe)
> >>  	hr_reg_write(rc_sq_wqe, RCWQE_DB_SL_H, qp->sl >> HNS_ROCE_SL_SHIFT);
> >>  	hr_reg_write(rc_sq_wqe, RCWQE_WQE_IDX, qp->sq.head);
> >>  
> >> -	hns_roce_write512(qp->sq.db_reg, wqe);
> >> +	if (qp->flags & HNS_ROCE_QP_CAP_SVE_DIRECT_WQE)
> > 
> > Why do you need a device flag here?
> 
> Our CPU die can support NEON instructions and SVE instructions,
> but some CPU dies only have SVE instructions that can accelerate our direct WQE performance.
> Therefore, we need to add such a flag bit to distinguish.

NEON vs SVE is available to userspace already, it shouldn't come
throuhg a driver flag. You need another reason to add this flag

The userspace should detect the right instruction to use based on the
cpu flags using the attribute stuff I pointed you at

Jason

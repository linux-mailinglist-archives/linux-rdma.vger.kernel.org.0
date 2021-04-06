Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A747F355F28
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 00:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhDFXAB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 19:00:01 -0400
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80]:5697
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232983AbhDFXAB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Apr 2021 19:00:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3ctnf2nP6SYw6kEcekHNRdc5htNWWpF/6lk13JhytKuAqkwcHD2I+dC3xkwHL/dYdUb3TBrrqmT6V1MumZecVpCJMlsbUc4TjmrN+VhFZbTT+3BLbrQ7gmJNnm2Uuq2WnGEkGWVIayyUA2niwGcSJdwDEM2sOD7FJQ6jymHvMczMVcsH5f9e+xptyZFVGKbCYQhso76LnLQKV6krw9pXQvc5KM2Fgdm9OP9HSBsyPN5lvXLZsw/3tSqDOedWG4+0fNyAcNoMSUrcvPkGrUPp/0rBv+gDhnL+B7yvo+9oNUdBTURzHAPk64esI7HQxPkMG2dN+8RYJrtlXkTxM9Nug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljD2S4NG2As5+NqmJ4uf7E5fcr44MoFMpBw04E7Zgi0=;
 b=ENFeE3VdAOpP7Ayv72h3QDYWs7D1qgvZPDN9txPau2vEPCQLmF6J0CSFHziNU5wGsXJMg8XbDMvjYxPR927cO6PofJJ3/GYOL2AxNozqq3mezLvH0dDV0OsNr6rScTuIUWZF74VJdZf2JGqbcc0LAOigz9Kt9mdAw5GK1b4mJyHVyEu/Wxo5cxE7fCfK93Csqg6CiNdkjuVHASxQTeIXSBaLXA/fF0OQ67J6XqyN5tR4cL51sO1sR1DqCX6kx+m5uwCcWeFWGiSO6RzWLWxSYFA6IUuVfOPG/6EXc4ESViH+ipHiu5OFH0hTCcoYrnh7Jg5Z0fyob9RR/imxDtAQdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljD2S4NG2As5+NqmJ4uf7E5fcr44MoFMpBw04E7Zgi0=;
 b=S4nkrQYrTyCRi/F80+hJ/WIpylI48fGYqC76vW2htophzyQv9MjU0UVlFqKmyfQ8Y997Hlbwd/PnJZwSRYtwdLaRrEbLssR6DYNNRuxurM5o+zszE5Wo1kwasjDpuBEbhAFfxD/NqeGVdYD2e6i3U+HRVcJcM4YBAx81l3Gox3i1pYDLQ9CmK8Ecc/wEbwZ/N/O8jNu6M0/ZeKy94RXEYpo1ED1Ycf8taiJvjeez9TQFpR85NKiBNi6NtaJHgcHk59SA7Cs0kr/BfPUlpauJDoacUo335H1aQHrPnoxDh1TfD3m9K7K8bqKNfw3vn6Ai9DoDdTTiBcZsLI4xP2/9wA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 22:59:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 22:59:51 +0000
Date:   Tue, 6 Apr 2021 19:59:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 4/5] rdma-core/irdma: Add library setup and utility
 definitions
Message-ID: <20210406225949.GA7405@nvidia.com>
References: <20210406211728.1362-1-tatyana.e.nikolova@intel.com>
 <20210406211728.1362-5-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406211728.1362-5-tatyana.e.nikolova@intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:208:fc::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR02CA0013.namprd02.prod.outlook.com (2603:10b6:208:fc::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 6 Apr 2021 22:59:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lTufl-001pNY-Te; Tue, 06 Apr 2021 19:59:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 541ab8d9-a275-409e-f556-08d8f94faf3e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4619:
X-Microsoft-Antispam-PRVS: <DM6PR12MB46190E5860564913CB44D2C7C2769@DM6PR12MB4619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rF60niAQZ4OUD+zmA+RQbiNk5Q3pJWJZcGhXR68RINeii/zfB2rVRa8zhaVyBLWc9CCabylY8fiT+t7jMWdXfUK0SH6J2wc4A5gw2LhYVBI3ZVH+w8nEDPzF6NkVgq/OzFHkDOML92do3doHfZdYuOs/DjMSC9h+zyjkwGmofC5vSI42L871To2Bk/iEP8v9+YgJ6AWIYpwBCFvmR2DzZlaUp1zyNWOwMUGYyMgtc29feF/1KjRsPJjQn6CGOk8foO+m0NiJ3l4L+XsAmBBQX7fbYpabWuPVj/ijAsWJTNm7Dlstl+s36h5/QExpYe8khCcI56ynxUwfuOc1Ak7WIk5tBcfPfFPHGR2CMyHpzAsHjbTudewuQK5oycTLMGVZ54eLaGkNsRI3eTkOd1YRfZ/ccyq2MvOumByibkxjuFT5YpSUEUzWA45yAsuhAXlM8vEprPpF6gWBr9aXVPLfvszCx34qregiA65bNqlRkp39YPqrbzqodfZnuIVPS/thoRJJBEgqhzDipxQyL6qBf9T0uL2jKrF7HARkkjU1q0LIPvBA2WnOAwLrypsDVsDt+R8/1VjUb7AMJzkcCmbhr3YvLRlD0Q0uAeemrVftrDrXuZRyrNTJoUME86hHEe+FsYe/5UoIX2XnQ8ajq8yuR5Smv6zp2PwBg0oZleK/bLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(9786002)(86362001)(9746002)(478600001)(33656002)(316002)(8676002)(6916009)(8936002)(426003)(2616005)(4326008)(1076003)(66946007)(186003)(2906002)(66476007)(5660300002)(36756003)(38100700001)(83380400001)(26005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vKsQxwT+1xy06S3uEk6USn0Nfanvf40Q3l4KRefU9AtBuBZMxmXZi3fXtt1d?=
 =?us-ascii?Q?uKEy21y7FGdXU/1zXHiKrICTA8jknfAF5tvh3mXXJ558Et+KHAYZ/h67WVQt?=
 =?us-ascii?Q?HzO5aPxcfG7rMIGu06ZxEA9LU1QSrvpIKvrnPtPbTbNdwSBh7U6CypIwnlF8?=
 =?us-ascii?Q?VZh6khf4LVpNp0puZnP+7GuXRWu8qzeBzrM391ETrvMR+vIYCfRGvfTX7U8T?=
 =?us-ascii?Q?srzidyyraR/F8/qr5m1EWgHYIEOicxUkmEzuHmQ7T40UdpyP4qewfCVmLoKA?=
 =?us-ascii?Q?cyIIsYVVQBQBKN196zRm5Yn2dvfKh41tuvGfS9sIrBVFV4aseQ28X0D6VIP7?=
 =?us-ascii?Q?zrRZZ+6nrhpHDApeRCHke3UzHYt8KMgVcBinShcc5Loj61oA8/i7avPGF5Hr?=
 =?us-ascii?Q?igb542sLt9P+KBxYCGBU6nd2BUUhNwUJ5mXZyVP4VzEgOpzklK6/Jq86DF9Q?=
 =?us-ascii?Q?f0dmeHs4YTnHT8zhXKee3s9A5qgC7MhvlMCzNc/2ofoLhIW+aDtOrKSpUYYH?=
 =?us-ascii?Q?LPqD/sYhQoM8ZqWqDeWhRiB/J88a6Swu6IlmYGezlG0cWIyEp2sQO4p+UmKI?=
 =?us-ascii?Q?0DlLuUio9k9/uf7WpwS1QBAlDoAexOvLJFlscoe096Q+Pr+eVq7x/qtjvHhW?=
 =?us-ascii?Q?frUPIgS1zVeTl3zuMpTEgoZNf36GOWZ1+A0eqdh/gNDVCA2GCENPLVO6eVrV?=
 =?us-ascii?Q?tD8b3Yx59YmBZwyBTQHOFjSknphsaQY6LFzTYtVp7Ef/riqP4UZpHTDM8IXq?=
 =?us-ascii?Q?CrCipDdRlsrzN2JMuGZKVrCyc1ikrRbyTtILzE9nBUQFHEl9l/E8NPJdBjyv?=
 =?us-ascii?Q?HMBraG0orDYwrLPk0wziry2P+qPkSiqm1CB0c1WQwsyglUlCk/Wook9IlYlA?=
 =?us-ascii?Q?6mbj+zYco7TYD1+ZqYQKjQjC0n/4eKmsS88W9VR85XExIb8wcktE5MYmfxEl?=
 =?us-ascii?Q?ww4gCSJgksX5DRGK0Hd2ivZVEZS63rDbIsVRLe11WN8f91ROpdEqKD/9hzBG?=
 =?us-ascii?Q?HsGjAkackbAFGwS8Hw0vHSMOUGgqmxmJv1k1o6X3hFyR4IBu1Bvjs8rD1x95?=
 =?us-ascii?Q?Y5Gm0QXPYD8fwDp66K9Da5a1vzNjAl1/QtZWyqxaQVdS3982rYbxkeURqYaO?=
 =?us-ascii?Q?++TKniLOUU2hbsWZ8txrZR9tbJxOrTanvItz6foglZT6Jf0r7h7TJR3YdVd+?=
 =?us-ascii?Q?7XDKnH2gnxb2hv2De2dq+EH72CcAR34LKUxW+4XhPZ96gwm4Sz2KEfE3dQM5?=
 =?us-ascii?Q?BRmGGsCaOUYDXRFo/c104TKfWogjuCW+JT6tVliCCeRmiV4NrcLe7phY2U9u?=
 =?us-ascii?Q?1O4CPdIUMSx3xgzneBTydGHi3Rg6l7+0GdEv/TtIfdM/Gw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541ab8d9-a275-409e-f556-08d8f94faf3e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 22:59:51.2555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Za1Ug2OJn5ynput4jyw0DKDCuEb5KsF7eBhUIncaYdP8tnc3jd1VCWt1DbzkG/v/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4619
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 04:17:27PM -0500, Tatyana Nikolova wrote:

> +struct irdma_qp_uk_ops {
> +	enum irdma_status_code (*iw_inline_rdma_write)(struct irdma_qp_uk *qp,
> +						       struct irdma_post_sq_info *info,
> +						       bool post_sq);
> +	enum irdma_status_code (*iw_inline_send)(struct irdma_qp_uk *qp,
> +						 struct irdma_post_sq_info *info,
> +						 bool post_sq);
> +	enum irdma_status_code (*iw_mw_bind)(struct irdma_qp_uk *qp,
> +					     struct irdma_post_sq_info *info,
> +					     bool post_sq);
> +	enum irdma_status_code (*iw_post_nop)(struct irdma_qp_uk *qp, __u64 wr_id,
> +					      bool signaled, bool post_sq);
> +	enum irdma_status_code (*iw_post_receive)(struct irdma_qp_uk *qp,
> +						  struct irdma_post_rq_info *info);
> +	void (*iw_qp_post_wr)(struct irdma_qp_uk *qp);
> +	void (*iw_qp_ring_push_db)(struct irdma_qp_uk *qp, __u32 wqe_index);
> +	enum irdma_status_code (*iw_rdma_read)(struct irdma_qp_uk *qp,
> +					       struct irdma_post_sq_info *info,
> +					       bool inv_stag, bool post_sq);
> +	enum irdma_status_code (*iw_rdma_write)(struct irdma_qp_uk *qp,
> +						struct irdma_post_sq_info *info,
> +						bool post_sq);
> +	enum irdma_status_code (*iw_send)(struct irdma_qp_uk *qp,
> +					  struct irdma_post_sq_info *info,
> +					  bool post_sq);
> +	enum irdma_status_code (*iw_stag_local_invalidate)(struct irdma_qp_uk *qp,
> +							   struct irdma_post_sq_info *info,
> +							   bool post_sq);
> +};
> +
> +struct irdma_wqe_uk_ops {
> +	void (*iw_copy_inline_data)(__u8 *dest, __u8 *src, __u32 len, __u8 polarity);
> +	__u16 (*iw_inline_data_size_to_quanta)(__u32 data_size);
> +	void (*iw_set_fragment)(__le64 *wqe, __u32 offset, struct irdma_sge *sge,
> +				__u8 valid);
> +	void (*iw_set_mw_bind_wqe)(__le64 *wqe,
> +				   struct irdma_bind_window *op_info);
> +};
> +
> +struct irdma_cq_ops {
> +	void (*iw_cq_clean)(void *q, struct irdma_cq_uk *cq);
> +	enum irdma_status_code (*iw_cq_poll_cmpl)(struct irdma_cq_uk *cq,
> +						  struct irdma_cq_poll_info *info);
> +	enum irdma_status_code (*iw_cq_post_entries)(struct irdma_cq_uk *cq,
> +						     __u8 count);
> +	void (*iw_cq_request_notification)(struct irdma_cq_uk *cq,
> +					   enum irdma_cmpl_notify cq_notify);
> +	void (*iw_cq_resize)(struct irdma_cq_uk *cq, void *cq_base, int size);
> +	void (*iw_cq_set_resized_cnt)(struct irdma_cq_uk *qp, __u16 cnt);
> +};
> +
> +struct irdma_dev_uk;
> +
> +struct irdma_device_uk_ops {
> +	enum irdma_status_code (*iw_cq_uk_init)(struct irdma_cq_uk *cq,
> +						struct irdma_cq_uk_init_info *info);
> +	enum irdma_status_code (*iw_qp_uk_init)(struct irdma_qp_uk *qp,
> +						struct irdma_qp_uk_init_info *info);
> +};

Is there a reason for all of these internal function pointers when
there is only one implementation? This looks like data path too,
making it even more puzzling

Jason

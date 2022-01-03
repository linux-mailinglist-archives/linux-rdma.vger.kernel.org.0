Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA6048394D
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 00:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiACXwQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 18:52:16 -0500
Received: from mail-dm6nam10on2051.outbound.protection.outlook.com ([40.107.93.51]:3329
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229487AbiACXwP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Jan 2022 18:52:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gz8iCGTd0F5aZzCiYcVVPUAVw/Ikm9Ohw/rVVMDwDxfD8qIZiFlpXxSBA1ndyiYrbVdotDxCoDSA7+Df+iqDORVCKjI6wKjDZldt0EbkwFhx7KW1wG/rqXMs/BMhLjfceqOzEqgZIem2RjDpOVhRYDGLFuQFJEAlx5RpbJjyYk8240z/Q1+X6yf4xt0sTr6DtlY2bLDPT80abtHiIIO8wBL9yAdRsSLEmQ5Ltu7K8Zi9AbMHuqqGp+b6s3ToIQC5C/1Lau9UNAPl5GvhBScg+Co/bFIF0EzJN2gNwmD/oPdUQHqI/tUzDLEB0SmTq/VNiEU32Drdn2mMyrPexH+Jmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJsYKqnbho9PXWSBXBaDRMib9xyZrzoUKgIjL57ag/Q=;
 b=kzf56RqwS8JKrkUdpZZZPQBw6WAH0WCRIi1kZpFORUipVC7+YxN/EGOh/aimEQ7WHfUgXsgMq9kbIxCCS01sG9me1zemaM+lLLczwjdoYd+sU6mIkbDW1L0BuzguHeSrNHZExgldeIf6ajg7gGZW1M1nItbk0lc60kh8ocpuq/JcYbWQBRGF6iiHt6iQKfFI/4TUZX3xHGyilLepnpORBpDRJLSH1QxW+RzAXLEzLZICGoC7x0dXBn2baxPHnt9XUqQk5U+aFlzJpmGGF9X4pzuRGRYD82noYKlefKtDFZEt8PmCPz10flRPEZGlwuSOgRObawWQwhslRdFuwQWWhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJsYKqnbho9PXWSBXBaDRMib9xyZrzoUKgIjL57ag/Q=;
 b=M2vCKpcGD17+pIvy/QsqdkLmipPICpqAC0Pv8iX9z8KRNK7xloifHd3KQzTykiZtCDMX/uIZ+NkUSVQ20SP216MU8oT8MCjJD3zs+57SI/20Uxs1/3Xe5nGzi+LnoOHBwgTFTF2YOf0cNBjpjLQ1oEiKCdynF+QaO50cOSVK7W26dkpySuFIQgbTlLfqEfmxbbKjpXp5qk15HOfTUPXHua2r5EbSPSUBBo6U5SZFZ8/gcprP5UK5r+u6BBNtQvPmFMKS2oJNF+Pu5XueVOsXkKmhhsZl2q6u1iSVEBe4vFYbHxSa8AL5LsDz62BNau+f06fiw5YaiJ6CRvV+ohu9JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Mon, 3 Jan
 2022 23:52:13 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 23:52:13 +0000
Date:   Mon, 3 Jan 2022 19:52:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Devesh Sharma <devesh.s.sharma@oracle.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>
Subject: Re: [PATCH rdma-core 1/5] RDMA-CORE/erdma: Add userspace verbs
 related header files.
Message-ID: <20220103235212.GC2328285@nvidia.com>
References: <20211224065522.29734-1-chengyou@linux.alibaba.com>
 <20211224065522.29734-2-chengyou@linux.alibaba.com>
 <CO6PR10MB563579D00D681B370A36FBE2DD429@CO6PR10MB5635.namprd10.prod.outlook.com>
 <717d6262-ca7d-3aef-528a-23850a42d888@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <717d6262-ca7d-3aef-528a-23850a42d888@linux.alibaba.com>
X-ClientProxiedBy: MN2PR22CA0018.namprd22.prod.outlook.com
 (2603:10b6:208:238::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8aed5af7-0714-46f5-c325-08d9cf141058
X-MS-TrafficTypeDiagnostic: BL1PR12MB5208:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52082B52908066BB101D6855C2499@BL1PR12MB5208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kT+oG3xT8aR0LPFCgUnLygJ/PoAv3x5lA72aMM+nHT854opgQ8I3XVfFUe/V/DlZMouYmCfFDZlutQAZ1b2BQxO++Wd9qpYjeICkgIV6l/Ox6Mf0Mz4wOzM+ED8qNwjRxE1oU7mgt6GJzP1NJM+TMCQVIbPyrRdD+9OxQVahSyO3dFbFeRIRrX79D3hAdO8kJ1muBdrYzeDqtud01QFgYdrcr9tc9S6asTBQiz5p9S1aUaZFslGq9tn4sB8cIf5SDs/mpaDVImxvyz8Lmoc0yqmJK1zZhvkmsGV1oua59SIxKLHc2Hn7DwPlgzzMqWPheaRzckyzi8fS0P2eVAS3r72szFUU37uD6yOgvxw8xm6dFGskvaShZgjdNFI2GnntXKsLo63WXH8IJZO+13S70x4MMPVBTsfHXEeQqvc1hUGk2N6M4cHox4rwORYEzOlrb/Qome1c0ADZMGj5TXCuktA69qoJ4vTsh1vqDLUFPf0XF4/ru3i3/4gxImiiy7MtPaYyA/XNxF0uiIW/gdgMhJfEWNuDooZI/FfmUSfzf7C7Ltj91etNkW0OzIA9XfKk61uddMAA5Px3yqOzduvGIYA/ZsC/wF9lL6oZIZjSOU7mEUA0iCxEiJitcqFwCoyjc80B0EE+8MndsiJy/MX3oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(8676002)(6916009)(6512007)(8936002)(54906003)(316002)(186003)(86362001)(5660300002)(33656002)(1076003)(26005)(2616005)(6506007)(6486002)(2906002)(4326008)(36756003)(66556008)(66946007)(66476007)(508600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9D81qhaKSa12FbeFBJjZTb0sey/jx0znj0/1l8WP88weBVKaGQemwKL44crv?=
 =?us-ascii?Q?Fdokd2DbuRu9Vr/1mkW8UGhk+p6IjyZeIWIEkJEzhulmE0ol6OnAiTkRZ3qk?=
 =?us-ascii?Q?Nv/zK+1zQqKuupGej6htbrKA6+yohWbhjpBt1mS6p/VbB0PUIFMgyuoMrMQw?=
 =?us-ascii?Q?usnPXLcP/TunPkkTq04cBZnXo5jTE6vhqYad1b9JxbtTwzZrC5AKTnBOnjmW?=
 =?us-ascii?Q?09G/8U1/cWCVR/V8QGPuvaCLCkSfO9vcce+YAHgfcX++GTNnUtXJsUNx3UU4?=
 =?us-ascii?Q?x4SQUKgGpyeGreNzRAweuMSSTKw693qSnoxpKqpzZe9QNXZpVgSzNvVkdvMI?=
 =?us-ascii?Q?sh/cT2dJxn7iXVHStyejSkFS+1dTLhSwhZWnacsTx3u6v9Gn4JPkfq9iXI53?=
 =?us-ascii?Q?LQumqWsBVvkrZ/rZRcz/IUod/i02k90DYsrcYKfwd+iO9HGqv+FOE0pmOr8W?=
 =?us-ascii?Q?gt3zqRjDS+X/yymExft+UKppvvr1mHgsOea/INvjl6zWN9V5iBf2shYxUpK9?=
 =?us-ascii?Q?dIQbpOGlOKgVD9al7CPNZkKbZO/KpJ5zmo+qPUKWlVO2Oeq9V2JIfC2tAZWj?=
 =?us-ascii?Q?v03Xr310zEn7enseWg5SKqhaOcAjY1e4c7V+n/qUaVH1vEukYweR4bewZcxb?=
 =?us-ascii?Q?UCuZJS49hvA8a9jwBscfRSolh41qv4n96/kjqdaitBd+4+4dVt47l4Y0oK8T?=
 =?us-ascii?Q?cNntaOMSf0Bj82CyvIL5/iSYtxHjJXEoW6INVXuV9iJ4LMuPGE+M953tkv/n?=
 =?us-ascii?Q?K7hxVymu6uXX71vk4KUd0s1qDI4JDts+SR7O8SoEJW2tewqbtsGFkTc5usAU?=
 =?us-ascii?Q?MZXHb8Jgp+GTB3DwLCcxOV1QrRzncKRswjKGcQ8KHO8HMzQpFrxXLv5bcEnn?=
 =?us-ascii?Q?13PtFUg5lAwHJY5p9SQoEfK1ZfeIhekB+QPz/9gyu48QyDhbfhb+23YGESl2?=
 =?us-ascii?Q?V+wf1ToFfhKUoJUYclql+Tlm1tLwiXoTTy41jAg7Rcuyh0yz6zikISLDvIuk?=
 =?us-ascii?Q?5oNGgYPqO2tWKFw92WoqcGE4Gp71a189GVkh8XYZtK53T5vQbnAIc5ILj8i2?=
 =?us-ascii?Q?4lQmQZFiQSRT1YgPlulKjD0T7jSkUiX6QJyJpNvx9JhzHNTRSAM98QJc6Kwx?=
 =?us-ascii?Q?ODIg1Z2YLqslVbxo7ZEk2F6TNgn4fCAWpConKdDKMUX1hl2KHbFQhfSYcy9k?=
 =?us-ascii?Q?tBe0HwYOc2srXcqchB9Z2vPe1SEml9l/XSi0hyDNNDAB9wHcgvACU0sZNgrH?=
 =?us-ascii?Q?/K5BF3ZmMPVMgG5memkSQvTFh5hRjrSI5Ci4ChVbjUID4tgMKZhJMkxNK92l?=
 =?us-ascii?Q?MkpkDpLRr0KTBlYRZ8sDLvcjNtMU0XvcxsMl6ZSn44eob94p0B6fPnkniFFn?=
 =?us-ascii?Q?0psLrsjqwRibdcIvPq2EnY8ZoG1UMeEk4CwdbBtlTtmMJDKbHxjEZDjKjnrx?=
 =?us-ascii?Q?RZDRRJmvfQtkrKLitPpB0CwswUt+WMjA7g5Zjjpw+6lumDBlrHJidF9zDw8x?=
 =?us-ascii?Q?eWptXlDiKeHxl4QWfUIx9QNk9e8xjDDWqytcDiOYE7DJYbgSGzp++Rb0jmYO?=
 =?us-ascii?Q?V837haKb1SIxGVSXVqY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aed5af7-0714-46f5-c325-08d9cf141058
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 23:52:13.1433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GriMBXEhoyec1NW2VIuS1Y9RDrOrl4qmhkhnDx2g83JytE1rlQLRxpmN/Ul+Wkfo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 27, 2021 at 02:46:49PM +0800, Cheng Xu wrote:

> > > +static inline struct erdma_qp *to_eqp(struct ibv_qp *base) {
> > > +	return container_of(base, struct erdma_qp, base_qp); }
> > > +
> > > +static inline struct erdma_cq *to_ecq(struct ibv_cq *base) {
> > > +	return container_of(base, struct erdma_cq, base_cq); }
> > > +
> > > +static inline void *get_sq_wqebb(struct erdma_qp *qp, uint16_t idx) {
> > > +	idx &= (qp->sq.depth - 1);
> > > +	return qp->sq.qbuf + (idx << SQEBB_SHIFT); }
> > > +
> > > +static inline void __kick_sq_db(struct erdma_qp *qp, uint16_t pi) {
> > > +	uint64_t db_data;
> > > +
> > > +	db_data = FIELD_PREP(ERDMA_SQE_HDR_QPN_MASK, qp->id) |
> > > +		FIELD_PREP(ERDMA_SQE_HDR_WQEBB_INDEX_MASK, pi);
> > > +
> > > +	*(__le64 *)qp->sq.db_record = htole64(db_data);
> > > +	udma_to_device_barrier();
> > > +	mmio_write64_le(qp->sq.db, htole64(db_data)); }
> > Standard function definition format
> > Func ()
> > {
> > 
> > }
> > Update all over the place.
> 
> OK, I will fix it.

Run it all through clang-format. Very little should deviate from
clang-format, use your best judgement in special formatting cases.

Jason

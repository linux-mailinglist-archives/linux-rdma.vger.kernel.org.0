Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45F766E1B7
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 16:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjAQPKE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 10:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjAQPJk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 10:09:40 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE0C3EFDD
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 07:09:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G89VVcpxQ+v0KGTVWOyc0By9UI2IeRlz6cNdUTKy35CN7rlLfSbmp27ozGd84XyF1Gy/lcgDQzTV2bjH6SOhTRwW9OPmEqKlkQqwxWohJSNbCfdIaIthqtbRho1QPTjxZ5ev9wsEsdkj0gz4oDuEB7INn7em+PC6b42HRCpE+AyD4rc0v5ddDaa+XlIQKedD56qa4P3KCKmGhM0G9LkBK2v3lGWhepJpQgls7Yh3+5PrnYexTQMWyW2xuCfd3HKnENKk0rzMCwssRqR72gB2qZpg3TC8mK31sM+1DaOEP0HTxGmNLHysntzVQl6oaEqniqXWLexChSO0deE8wQW/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5TStXy8mMiI6m+cCYLgsbMfabSy6TtWpCH6/gR9ybc=;
 b=bS616ZZY8GVYuRtnhRXgimp6ZNy+7/i6e7hGnJRnXwRQKDrqEkgpkfzd57bSzXISw4YrNRoJgstHvbIhFUSKdtWSRorqGw0HWEE4AKtPndLcOcOj6Fl5K0BDvI58Zg+c6BgCYC5luHwXaw10LWxVKQeb0S0exVyHEAq9fr1wjpvPSURON/2dPA5EUqMx/obT5z3FNnKz/SBXOeo7izSVNEKCCIQlN1S7sNBXl/nDl5OoS1H44syDjSAFmWb2V+/xsuPeZNjJndn4vuBBXWLlDpYyf0cRdIbEl+ZUwB5JyhufAR3BGg/6hFfEOIq5lGYW07/ikTGSv+OE2bnOpsacdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5TStXy8mMiI6m+cCYLgsbMfabSy6TtWpCH6/gR9ybc=;
 b=WimvR4hHrtURVdMbjLouq6wv3UDe9bl0oO5U5WEJFR5Aubm78BLjKvti36SGUAepVSCq9k9QEkq6wd5F8oSQx+ywKILGKYJHLbqTVcv+b3zoqxMpRN6WTU5VFQ4K0aIdlMv032xA26olXvwYkUwEblYIN0t2W0U5cG/cLnMAicZ7wA0luvwxx5fFPSGsffdbwOQI0GED7J05yyF9DWxbDy5UHll1jWS/9ZM+nY2MUx7lMpVS3E3XliQFnnEFPdXhZptLaJ+dFZ5G8+rCSmuxFHBaMtR37LIukcb8ZKa8M4C744gzvauxq1lwdFoeB1Iz1FaZ2duUctM0WjjVDQAN3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 15:09:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 15:09:37 +0000
Date:   Tue, 17 Jan 2023 11:09:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com, yangx.jy@fujitsu.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v5 3/6] RDMA-rxe: Isolate mr code from
 atomic_reply()
Message-ID: <Y8a6MQmBqiuhfwKy@nvidia.com>
References: <20230116235602.22899-1-rpearsonhpe@gmail.com>
 <20230116235602.22899-4-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116235602.22899-4-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:208:2d::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 60376e4d-2b7a-4eb2-23bc-08daf89cd9b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1brov/pZvCnNIRH9HOK8VaP83oYFx5T19TkdrDTvVTqaFwADRXPy3bQ5ovDshUAylHMFy76D6eOPc/xT/8cK5vLN9he+lCJIMgJPa2BwFKXS+BlaqqmrQ81ayUpzP8rVEG7iQwHznAgY5xnp074crOc9WYWS+J3ChnIz2XRIcr0VruBJV4IGvA4DBMUF72OoUvKoXLeJc5i/Yl9eVlWXQpRX+qczvQZT6XUwr5E6nMrmaz3kUf1//pieCVeMzLcdB3L/mJahfnvcMxPyrd5y0qNaOUQBzy6qFcLFrvibn/0IpeThBfFZ0S0Nslx9LVlaYeQry3UaCP5Jz8QhaN49pay3BVRDRy8OVb4VF7k8yjyzJhRW0b/GJVWqL2JStPZYmYqtvhXLJVliDLY0ZY1ZQY8DqhslPENED5xysFLp2qQRBhtSFevlTONLE6pUki06smsFnh1NR9Txpo1dbKdXuCo2mbp7/VgWM13oXhGXq12bgBZzQkL+OldkIOZuQ+5e1wwRKJ1EQSLD7MeJ92JYhsnDoZRkPTqqdf+TPh+B4pbtjSfd7yJBeR++wNuSMHU81QiqNcnqKSMj6B9uKuhWn4b6YgbtEk8QkkLDLCgk+PD7o40Q8B0e76Yn0rrQCAYoRn+tvbHBStaHdb07fPvvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(478600001)(6486002)(36756003)(86362001)(8936002)(6506007)(5660300002)(186003)(2616005)(316002)(6512007)(38100700002)(26005)(66476007)(4744005)(66946007)(6916009)(41300700001)(4326008)(66556008)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qjKGVKc8b9ic965fZEVGVVBsi/EHweZTChOoF0YdbsHnofoBIrR2mQvkhn7+?=
 =?us-ascii?Q?eUVqVIeSAYNe7Ow7MMC5PNSMGG66ZSk8aYwI2EogPsVRCGwiOEMBRuqaw/p0?=
 =?us-ascii?Q?J+sNfT8hQM0K+GCSD/6q/3yItVX9Dou24k+PDxgypCYT7wHO/0rrA46bAO0I?=
 =?us-ascii?Q?KjgAPrj+zZHNfYZ11qepWRWUjoDH1jn5WIHKIvjHJh/eKeGjK6FsjI2tm2YF?=
 =?us-ascii?Q?MjJnRrlQW5S6gB2afbBi9hYYwkaLUssaA2FBW0uiN8BR4rNlXnZqGlIZxD5X?=
 =?us-ascii?Q?t+ImTCNIzGOHN9WF+sLpPkllXaKJOTt37nviPfxkJuI2chA0HsIaOQglEYjt?=
 =?us-ascii?Q?Vou6M895Qtx6G/jPNV4k3seAL9zwzBb8IogT3ktOJ5I4Js7fmN0U2UfknJ39?=
 =?us-ascii?Q?t7i6KRPlNSdNq4cizHE+ioDiiqnc7ya22s7yE+pD3eW9aWV1dQg0gmGJTgI5?=
 =?us-ascii?Q?21aGrSYFdtUyFJGE3Qzf46T3/WRznlHQGe1TBdVFYZaB7Yt0oU5bLpV99K9C?=
 =?us-ascii?Q?6huH1R3OKxiQTkCQnse54g6Z2nu+wJ2LIL3KX191eZbTIhhdtVjR5RkDPEoi?=
 =?us-ascii?Q?9kOMLLrgunXBkgc8hF5R6Th6Yu/sy2Zr0RapZVO3s1N0nDoq9GET0XtuXJQd?=
 =?us-ascii?Q?IyrZEi3ViYCh3phQQtlHYb3mQQ7t6kLRzFIOwYB0nplx9NCSe7avt/o0yFzs?=
 =?us-ascii?Q?7xgNJpuTPywKIQsxP3aPVjZswMq2mslUtlv5JWv1yyxB2WA+reaILlzav6N8?=
 =?us-ascii?Q?h5X2Lrx5AOj6JWqD8uOW016VD8M5y1lqD5drfTq5on5LF8s4UKbm7k8yDK6t?=
 =?us-ascii?Q?5cOihGDGP+uZpiE13J8gEA2aBloHMpOdGAeb79LkpX/1uATJ3PbVWjTZZm5R?=
 =?us-ascii?Q?tLxD46uxEKKJypZE6fmV4Dg097ZjLu/qrI40rfbzGsS30GOkyjuxRMPu+IeD?=
 =?us-ascii?Q?I7PJxoVzDh7SGG2mwPO3cjTQE7n93kLN6Q+vrYU00lD+TEg7WcbilyuGLOp7?=
 =?us-ascii?Q?8jSRrvBc0jBccoo8p4BhjPojwdFWj3k7Vr8v5qj9U4Dk0Y4MAqDVEEmz77II?=
 =?us-ascii?Q?2OHy2bZUv9ArNNSNel5oWVNLCAVX6/ormPciWgibapbivXN3lP63GEYfKGvg?=
 =?us-ascii?Q?7cuqACFvs6yZK+9HmfmjMGz8NqZz/7cGiEPBomcM1Qv9RPvnKC2Rpz/5HGai?=
 =?us-ascii?Q?QXZUOT20VDwncYM4CkHmQccaJaKi8M/mkVS6YKLtmoM1pn7oy+KTLJXhbERG?=
 =?us-ascii?Q?UUoN92d4jRTaHzUBIXSSTWbQcNNV7hgMoeMv1uEC9x2O8B3cgPe6TAaSfDas?=
 =?us-ascii?Q?ku/9TOR8AtLciBZE7lNE16D+DITRs7lZid97Zl/CXk7YPi+cjQLcPSwFW4sq?=
 =?us-ascii?Q?p4OQLJbKqtkJAQOIH418dWq0Q0EvCHE7RLh88QLW3Ash7V6ZCdPODA3JhBDo?=
 =?us-ascii?Q?p4pVFr1VjkOeY8zWz5D/mOQWuX38Vk0Yxh1+OlZLJDGHJIJygMUcSfGbzy0w?=
 =?us-ascii?Q?+ulSGwmG5R9s0UEmou5pmYOQj7/Sgy4xtE9eqOaQiaijobwSk3uvMdSLhrIM?=
 =?us-ascii?Q?8pn6hU37r9WOBs1QkpaFrthFRILNNDAHEzTvkoUL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60376e4d-2b7a-4eb2-23bc-08daf89cd9b4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 15:09:37.8644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sS9Scr4ntmvErMU/BjJErA7W1MXu1iod25sF61CuGC7FD17pszC2AfSLOK9/7Tk/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 16, 2023 at 05:56:00PM -0600, Bob Pearson wrote:

> +		err = rxe_mr_do_atomic_op(mr, iova, pkt->opcode,
> +					  atmeth_comp(pkt),
> +					  atmeth_swap_add(pkt),
> +					  &res->atomic.orig_val);
> +		if (unlikely(err)) {
> +			if (err == -RXE_ERR_NOT_ALIGNED)
> +				return RESPST_ERR_MISALIGNED_ATOMIC;
> +			else
> +				return RESPST_ERR_RKEY_VIOLATION;

Why not just return these RESPST_ constants directly from
rxe_mr_do_atomic_op ?

Jason

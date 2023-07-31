Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023AA76A049
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjGaSXs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGaSXq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:23:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664CA19AA
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gg8bfJcdmsSlrfqxRjD6cr3xLH4GQyFNAk2tJ+Xv4cms0pBdi09id8sURELyrAj7ck6VEpSUTFEtMDG9p9bShkCW78CXWlvEo4jF3tHWhBVpkQvn/+dyntVPcVoDmQHcaTRsmNJmqPQPNM2ysfeFnjVoRExLKjUKNUOPqEukA5vtc/JMK2+NxSBNwOeI0kK5WV0boofpW1XXr+gsPV2lCNd+bvWyqkkbindNjSvGuEsL+cuXiq2Dd+Ug8WnS548kfve//WKRCluNNCVyLFx2+QBsCvpLZBoTA1E7rByqFjX1MOJisb3gm0dmafDD3YRe3d0n8uQWQmBWKNuTgAPfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFt7KOn2giwcEBV9s1cFjDq55VNq4GPhZKuWiu9SQNc=;
 b=NHPRqCSRTKTK3UREeb+Xf0612EXiTlnJS0CTf14wx6jIyNr7PHNpg4CAvEtlxA6GHc2fn1A7m8W449YaJwJTWKfGEagy0VTi1J7m+Ly/IEUT55Z9vsU9Z0nlSk4NbXCQXvA6XB75JkGWXeM5vnCuU5ltaFvnLFKzYvsi5srpxvX+Rntmn+xGhfomJx1owuqL0ZycHYajqQBrAwmaQZ+QRKXKa86flg+4OzzhSJ9oX+q/vcnQjYmFTgUMKuYpWKqsgQKpxSoUz/beqHQdcbwLVwFK6XvklrRG5WzOzXlP4pHMORC/JbdxwuEqtB5zuL+PKev+JsPBE3Q9BEA4zQcO2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFt7KOn2giwcEBV9s1cFjDq55VNq4GPhZKuWiu9SQNc=;
 b=LYXy+8o6/Xea6rZtgMvluwPBpsqFUvzSjXk2WCGLkOd+kSfXXohUeH5FwXcnvXfnCeRYxpk603nZU1NfgdGSq8QAXde37cTeRaorcF55d8PBjntt0Bbpa5SoEVcnfyCq8Rr76XYXlRs2X724BdOdQ1Jfr9u24SZPnO/dBA7yrlqcd+0J/2FLkf5LTPrDITQhJZF0PiXFmFSgAckJW0jDrdu9klPmFKSlGjvurIry/uWQUa/6s3dyZviWXwwIzRIkvzP++Q80Zn+NrzqMv+SB7sv4TtnErSiW+NcoXhCBxZ7L3Q86Ihdvr3OlvHcvc99D8cTSo5WB8WrrzEMagC5CgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 18:23:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:23:29 +0000
Date:   Mon, 31 Jul 2023 15:23:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 4/9] RDMA/rxe: Fix delayed send packet handling
Message-ID: <ZMf8H4GtL4EZKGd2@nvidia.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-5-rpearsonhpe@gmail.com>
 <ZMf5qhbrgx0lBv20@nvidia.com>
 <f38c7db0-e613-f840-e979-76383460fd7e@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f38c7db0-e613-f840-e979-76383460fd7e@gmail.com>
X-ClientProxiedBy: BY5PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 117d074c-160e-42dc-2b7c-08db91f33d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NYlX4bsmZ/XV98fir2wzStnmop/t7RGi6yW8GWDxF6DRSH1KAFddV+GicjCrQqmh47oG+9keAAlRFbGxh6irVYDxGHOeT66Thg76D3SC3qbsg/XboewDCKabXbfZfXN32yeeSIVU/AyESPh9jLTs61M3reTGke8f26FqxKMoaxh7OcJ2ipM8XicYIDCWcbqY8+/Cx6CxCvqjSccZbblpbeULLpyzcDaWU7rrFXMQ1wHSmODKVnCKuD6TUWT8C7++J+hwPVTDLz8XjDZphTtDETWUjcNsy0yDqOBn8gpvzIfnIlC1hzFGDftBLVJgA4v57jfGAijxsRmOw2W1ltWJOChP8e/FRIowhTyKZ2xLAUCP8sCs3CNRT1wlngCl3AHtSUxK6UaOlCKtgI97y65lPZhk+hygI/+Th6/+VvnKC57FqgNq2x8V3h1l7LLA//FOEZ1R5JGyaRHDM2CA6foyV0KGk4n756NUE7nE/nbJmibPXAV5JzAhv63C2RZKgM7CizqrHSa8dD7hUU8WBphY0o+I2HO1ZN4GkVqGGNvjvAghoeD69MGR7KODMNBnMcY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(5660300002)(66556008)(2906002)(6916009)(66476007)(66946007)(4326008)(316002)(41300700001)(6486002)(2616005)(478600001)(8676002)(8936002)(6506007)(26005)(53546011)(186003)(86362001)(36756003)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oV+5/+1J6z4zIXXZodsNvpfAhiHPTaNzwxb5nRa6HGKq1U53aZNKKGlq771I?=
 =?us-ascii?Q?n/rRrjC4AmpaiYQ2G6ObOtozmyGp26BCqK+933T+8lpYQWxvNTx3XYhL4L66?=
 =?us-ascii?Q?iiGRwpdYEw6ZksW9+80bOjRSoZeXvkI+SAJTc27sQQ49/HluxxXwHhfiWb5L?=
 =?us-ascii?Q?QzORY6toOoB37V7bmAVF5RKY5jLyzdVdfMWm/Wg4deHt7davQgfcoju7co3W?=
 =?us-ascii?Q?vIzmy2qbtxkuwvphXvVxYbqKQGGJV2l2+fZtTvPSb7+dMRqH7hSNYNMtuQdE?=
 =?us-ascii?Q?vmGtqcWY2AdrqZn+dGdXOfRXBA4PPRR3KLicwOxLCBCCYqsxFNQnOISrX699?=
 =?us-ascii?Q?Dif+OL0TodnYd/25hbgQCAT+PifVsy6x3LGtZV2OHgSzTN2csTdAGUGmrWWz?=
 =?us-ascii?Q?2ksBOGCwzDZrqB2+I6bbLDxFaH6Wv83VWYQuh62MRgmj0Ts4FUlk7035GBtE?=
 =?us-ascii?Q?Fos58d+cNMA/2Psh/yZ+/oAQOIKmC20YPN5TAdjeUl2wlCJKJlCvaj0Pm6dM?=
 =?us-ascii?Q?1QMEwRMNJRZKAMixSDdRbhMyQYjLqUzrVIIEZnO8e54UIi3pW32RFLPZlnKr?=
 =?us-ascii?Q?gAxuUgyorbH9grAqALZJ+YgeD5CqzVRN56joSjp6YKhBXFJ8bI62F+V+7Mx+?=
 =?us-ascii?Q?UM+xe4lWT2yDgI0ra+k/n2UsSLEARFF1Wmc6NKPA+2lFFxgR2O9QJO+TnTB5?=
 =?us-ascii?Q?YecTukx4S/HObbJO5IabiKow15kfx74XlnNoIGpk9rLB5CndLxkjt6INtLcY?=
 =?us-ascii?Q?L6wO54uTI0xnbaI6d33H9F0qQaCm3Q+cEqDmLCKqUnI/s+vFdhGXY9g2GRgH?=
 =?us-ascii?Q?93QjDu4XBAiDaRQ6ko+RYTvmChFqSmlZVxr6Fdxlm0ZC2YrOkzBrPwuWBFpe?=
 =?us-ascii?Q?fVaIK3Km1c/7Sf25QuaTnUxDC1t8iUKjAfhZ08Il+JcqAHoUBbVxkZ3O/0ba?=
 =?us-ascii?Q?Pv+PXNRSe1dM44yY/htLuc3AWiKUg+0di/rtmM9RW4JKdwX1c0MtEdz4RAkp?=
 =?us-ascii?Q?GMm1Qsi1tzCg4wkNgEq00OFWUOOnH//UtGitwrfQirz8XtrtflEqJaws6ZWs?=
 =?us-ascii?Q?en03efg1/X8MYHDV/fQwJmiuB2Fct7wPmSQu846syzrCPCZPAjJI4BjzAVu6?=
 =?us-ascii?Q?bjFEg5OSDg9tq80sWN6pSe4ZLsAvffGTs0XHZ22ZwmKSzAUrU9Ohhk80aAX0?=
 =?us-ascii?Q?OOkqpRRxJuBT52ijR61GTmaXEn3ClZvEYIOYAlD52ATJmPk/uPzRwebs7bQD?=
 =?us-ascii?Q?oSM9fWbwFBAmAHJSu/86AJerjrAsXl9Dsp9bjX18ScPEF8xF8GIAghnhgtCT?=
 =?us-ascii?Q?vmFv95OfLdVvIelwBxrD3NOg+gOtGMI1BchIh2D/W9So4gng0Hs5uuTD4OvF?=
 =?us-ascii?Q?VHWRsngxmQRw4RcwDxpegGTLWHDcEYvx/sGpdh/CKm/7UP+jOQHFKqeOpFVb?=
 =?us-ascii?Q?HDkquKeYumNehdxDjX6xrCPExddCjm8Sb4NXQeuzvaVU/t+4yW0OiIp99nYy?=
 =?us-ascii?Q?k0sdEQ6GDNOQ/Ar7Zpu74++dpPWzDDdokUMsrhMaZIchZFEeNXCHe4ob/tEb?=
 =?us-ascii?Q?6mAfP5mX7ziCy0US/artwTw+LvqOWrbDsSbzLhfL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117d074c-160e-42dc-2b7c-08db91f33d07
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:23:29.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RB31iQtGGsjAMlXZ1shh/+6lpftQ71TEioVhsyvQWloN/FnUDSY9KOyBfh5k9+ZC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 31, 2023 at 01:20:35PM -0500, Bob Pearson wrote:
> On 7/31/23 13:12, Jason Gunthorpe wrote:
> > On Fri, Jul 21, 2023 at 03:50:17PM -0500, Bob Pearson wrote:
> >> In cable pull testing some NICs can hold a send packet long enough
> >> to allow ulp protocol stacks to destroy the qp and the cleanup
> >> routines to timeout waiting for all qp references to be released.
> >> When the NIC driver finally frees the SKB the qp pointer is no longer
> >> valid and causes a seg fault in rxe_skb_tx_dtor().
> >>
> >> This patch passes the qp index instead of the qp to the skb destructor
> >> callback function. The call back is required to lookup the qp from the
> >> index and if it has been destroyed the lookup will return NULL and the
> >> qp will not be referenced avoiding the seg fault.
> > 
> > And what if it is a different QP returned?
> > 
> > Jason
> 
> Since we are using xarray cyclic alloc you would have to create 16M QPs before the
> index was reused. This is as good as it gets I think.

Sounds terrible, why can't you store the QP pointer instead and hold a
refcount on it?

Jason

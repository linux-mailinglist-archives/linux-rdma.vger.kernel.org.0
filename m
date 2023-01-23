Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11846678676
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jan 2023 20:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjAWTgZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Jan 2023 14:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAWTgZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Jan 2023 14:36:25 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221DD27D72
        for <linux-rdma@vger.kernel.org>; Mon, 23 Jan 2023 11:36:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSLGnJjgQsvnoM6fNmPltkc2k7e7BN7NKr/yfkWoRB9Q7GetXhD6S1fpcaksiSBaqKnrx4GzsjKSnFPv4xUyLYAFE3OkEsG8QMcHSItQ83OYk7DKwMhPl2S3Kh/6CC7uOd20oFFHtplXxd2pdDOP+ve5lYJJLnuLIWFPUM6UuZ7L1nskvKdnPVLtAwZlkbp+lrdj+B43YGqaoRDdSmC/bQ7ghNopdmMAJGc/F+SsSUs3TaUTfM/LCAUF4IBPaUIu4r5cUU8s9WM9dXjXMv+tWeRriLxc8WvHFH2PCRAiP2vTjBcmBvJGmKg2CZ9eOkpCAF6lmWZHz6E4npFESylOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2rKN/qJ2RSZLEZvc3r6giEXQEq8rG6mtsuhM1Lrod4=;
 b=oNrkdS8lFWdbG6uurWJXGv41Z+02nKjkFLTEf/M0w5DVo3SRCcHjVDBAJl/QRBmp51EIVWC8/PHT9otw0oENde4XrnkYFmnSvZ0UnzzYEotFkRsNiYzBsLSMaz+YcNMMRZoSxKkkvQ+9Kbbo0WEi2UKHVihdSLOS1BPSlHBluAtKBuRQmRStrhM512z6h25zd7sgSmdFemQk7pX42lMU8aRgGW5wsMZHJhyfvbOCNcfZOEfD1D13n8EWZxIPjFqC3gyghH1tnlu66Z74AQTKA1B+8jte1Z6D3zaD9hWJta4jhVqev7d1Gh+91pFrEUI5jblrXN7NhmERTXS0/lC3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2rKN/qJ2RSZLEZvc3r6giEXQEq8rG6mtsuhM1Lrod4=;
 b=QxV2txFjweiogxTeBinXE+TTsq9mUC/IsZkmLteTz0IZPGTdG79wJ3QXXZD4TR2ojk3TC4Moi7xgl8S9LD9s3G8GwawY0F6xVzEPbzWCwci9YkeT+T8Dm2bLwRaVa8EDGX5Vwe3HGHa5RfzTTbiMe9O3SFgkGJ1V/gHSas3z2vv0OQdCCbLVME2Pwm5KGKeKUEHjtPTRT/g3pGzKUsegC9kAnwCiy4axx0f+cMRqf3jHUWadj2sWGJgGsZlPhjBfzcPHhOw2LelrQeyaOyzhJtJfLHaEUGQ+qCiROj1pGiSD8mbqWSOdhyaxZeK9eVPFl3zVc/5Ppa2vj0ndpyQfbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 19:36:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 19:36:22 +0000
Date:   Mon, 23 Jan 2023 15:36:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com, yangx.jy@fujitsu.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v6 6/6] RDMA/rxe: Replace rxe_map and
 rxe_phys_buf by xarray
Message-ID: <Y87htSGRDR2pjAvW@nvidia.com>
References: <20230117172540.33205-1-rpearsonhpe@gmail.com>
 <20230117172540.33205-7-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117172540.33205-7-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0432.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: a1fa490d-5380-4386-e639-08dafd791b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/rvD5oyBZEnAiYibAd6GJnQCPZCaN+HVrbY824hgdTorsU7MJMo4VKx4vQfWxpMMxwnh5Mf6gGYCeIx18Yrm+bmT2UXlPwxu79o2rZgnVqidaUIAbiLVhXyqUawVCx9G5E3PALc/06sOzCd/Gtca9+0HCGHDO+zHvaxYXYgPK9Xudr0nmizN8u/OsC9sonJ1kF/ElX5YgdF2pG11JSMAsIs/JdThW8zCLakrEKxCVAcSS3YlVaEnRRxWOa4ebv4i2Rp0KJymi3vE4LCDtEjiaf6mgkGWFCNo/BkVSRb1nmiFTjaAarCF2wTM3ndhGHvE7JA9it6qOJw0vIZPjZMYAy79V+yMnzLcv9wEUamdfqEybVy+sUQMRaTYlw5+0AXJjMsflQbhluKWCT1n1kEdux/YTBP1oqr6dXNUAakGTN9C89DFnKxFfb/Nc8yYZi365cyYJQZtbsW98Y3FR78UtPG32Kn5s1E5mE1N3LN4aBnfK0p4F76Up03ev+E6iVu30tAVTWQnaSbK7t7a6boR2v1iNweTUR2oYs48Re3dMjXQHbrNRmSAJ3alO2MhdMpaXkf6wFaFR5q45Mgz3OcOzoWwnBmdFvVMY+iELvOiYxxo4Ogd2Wt16mZoGnK/cVXQMh89HYfhFbLnNnwSKh6RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(83380400001)(86362001)(38100700002)(2906002)(5660300002)(41300700001)(8936002)(4326008)(6506007)(6512007)(8676002)(6916009)(186003)(66556008)(66946007)(316002)(2616005)(6486002)(478600001)(66476007)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vxb2beefpp9emjJ5lYDM0q4gZxyH1gSUgMijzCmMVb5KTZpUxU6LxQSSV1nV?=
 =?us-ascii?Q?X2jZChzOb9SWzTp75nZvvTSHeMHkP5/Vponn8Kx+gLmz78EYY+1Qa+et2Yte?=
 =?us-ascii?Q?lOaABXtUrveYl7b3y8IAWbF2wa6mm6Pw4j+dhcUTP+0NaoeVftVIoElmCEi5?=
 =?us-ascii?Q?YPK/BJhdq7RGVSOicupGMXNLOS6Ktgvao24iTN55vucHbiPLAOCGWL4irTCg?=
 =?us-ascii?Q?Y81TjwVVcxculKxVUv+GPbhYlk0ZRWl1MZOf7ssNP21CxkDBvHMX2oOJEcPr?=
 =?us-ascii?Q?3W8olKEhgM7IEWZ5gwvpAIFq7qDziVkJ3D52GXcNdJZQNON28774DqpvVVU2?=
 =?us-ascii?Q?CcZ+skV4gLIY8qcUUlLDlXj4Q8ux3CyGfiFh8BEnQNieKjQVf7+tHMJ8WfGZ?=
 =?us-ascii?Q?GNCc8WVre0JV8+r+1zZ30GxhmiVcfUkkk9iJT8HgmrizLTl1Zc/EanpMcDx8?=
 =?us-ascii?Q?JlZ/VdzSg/gqSVvG27aV7gLv/zb/u//6WxPcrhzgNSweLD6cq1DhnH7Y0BYW?=
 =?us-ascii?Q?GXwhBmKugDxRPE1c5hj6DRIvcAWQgr6Y02cg8IlRhJmQGZkAU31voF1vv0w2?=
 =?us-ascii?Q?Ea3nYThMlnDjTAfX+stT0ib7Ozps4uSyDsls87h4+0z+cX/fG0TmiUS3UVaW?=
 =?us-ascii?Q?XF41CcESMFuq7GeCeAA8ZFIUpbcFRKHPCc2B/jToI50BQI/BBrTkStS3f1b8?=
 =?us-ascii?Q?8GcGnrNyW/eef/Fs4lOw0voto5CEbU24j+wYLLgNu2emYlHR7y/me+REfUBl?=
 =?us-ascii?Q?tzLbkdUHMpeFoDoLZA5eacPyQe+XnT67yd+mpmNVx+KwF96hV9DZ55MF9vzX?=
 =?us-ascii?Q?hNXMBEOQI/i/FiDIZxL46gFzjEvuomaTSCIMHX2CG5ONWD7m4f0A/kz21IF9?=
 =?us-ascii?Q?e0L6B1mt7qhpP+lE1HRls7lebTMRWGgg2bm6EzWtWJhBEhnWh+vH2pteXINM?=
 =?us-ascii?Q?wyl1lOnoJoUxga49uOJwphjXxqHY4llMKOmlZ85fmbT3df4mjB5C2QTTcJli?=
 =?us-ascii?Q?kvPg0s77K+TkgY6tYspnPkalI8Lhv/7KFZaeAfvNXjx+HctoqFwR2htx3n6q?=
 =?us-ascii?Q?xlAEPCoeZIowkqmjAuaFacaktDZvt5wUzSiI91KaqagZDIqlsQ9L7STWBsGN?=
 =?us-ascii?Q?i+/QIEapwo2iimNEFGNrj7hQwqX2Syd1xn75J6rHEQ8fjRP57n6W1EI4/uaa?=
 =?us-ascii?Q?11TuAqruuIUPGnQr/X5jFs60VMKxKoRDl/OliOe0q9cyp4+Vpoh2CDBHCPvc?=
 =?us-ascii?Q?dmjvVZaQXG3dTS3TQIyuBKVoA5OwPz5oYVDSfsSAR+NWIppZ1v45nyk6qLIc?=
 =?us-ascii?Q?S4XtVFBxbaFnBgZybY0+tlcV+YFYjhfbNVREeA5COmXMS45WvvJb0pYAL0TZ?=
 =?us-ascii?Q?uEzNu46b4JsLRDYc/Yk2N8YnCFE/QNtCxDvvjt5e37sAoQj360pnNciSgjaE?=
 =?us-ascii?Q?Y/8zDkIV7r5MFIAXlKDTcR4lwK8RD4TU+q7Bn1QRkdY/G7a3TEhRb8eXwKKW?=
 =?us-ascii?Q?ozq/CapR0giMJS+GyqdxGgVyxl206gbnwXVQuhIpaYNi37ffTfe7ZPtCnm92?=
 =?us-ascii?Q?Y2s93iCPWuD/34zPYa/f0GOMzj5Tob2K6mocUVSb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fa490d-5380-4386-e639-08dafd791b73
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 19:36:22.0890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaosTtA2SJW51vS6Zskkjr965Pc6FgInXZG7HRUJC3zhdni1xYA03hVLbZH8mH07
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 17, 2023 at 11:25:41AM -0600, Bob Pearson wrote:
> @@ -574,27 +559,49 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>  		return -EINVAL;
>  	}
>  
> -	va = iova_to_vaddr(mr, iova, sizeof(value));
> -	if (unlikely(!va)) {
> -		rxe_dbg_mr(mr, "iova out of range");
> -		return -ERANGE;
> +	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
> +		page_offset = iova & (PAGE_SIZE - 1);
> +		page = virt_to_page(iova & PAGE_MASK);
> +	} else {
> +		unsigned long index;
> +		int err;
> +
> +		/* See IBA oA19-28 */
> +		err = mr_check_range(mr, iova, sizeof(value));
> +		if (unlikely(err)) {
> +			rxe_dbg_mr(mr, "iova out of range");
> +			return -ERANGE;
> +		}
> +		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
> +		index = rxe_mr_iova_to_index(mr, iova);
> +		page = xa_load(&mr->page_list, index);
> +		if (!page)
> +			return -EFAULT;
>  	}
>  
>  	/* See IBA A19.4.2 */
> -	if (unlikely((uintptr_t)va & 0x7 || iova & 0x7)) {
> +	if (unlikely(page_offset & 0x7)) {
>  		rxe_dbg_mr(mr, "misaligned address");
>  		return -RXE_ERR_NOT_ALIGNED;
>  	}
>  
> +	va = kmap_local_page(page);
> +
>  	/* Do atomic write after all prior operations have completed */
> -	smp_store_release(va, value);
> +	/* TODO: This is what was chosen by the implementer but I am
> +	 * concerned it isn't what they want. This only guarantees that
> +	 * the write will complete before any subsequent reads but the
> +	 * comment says all prior operations have completed. That would
> +	 * require a full mb() or matching acquire.
> +	 * Normal usage has a matching load_acquire and store_release.
> +	 */
> +	smp_store_release(&va[page_offset >> 3], value);

The 'atomicness' is that the NIC side does a 'release' and the CPU
side will do an 'acquire' when it reads the same memory.

The 'acquire' from the CPU side will ensure that any prior writes or
atomcis done by the NIC are visible by the CPU - because that is what
acquire/release means.

Eg if the NIC does a RDMA write to X and then an atomic update (and
release) then the acquire will observe X too if it observed the atomic
update.

acquire/release and rmb/wmb are two different models of the same
concept. acquire/release is more datacentric and tends to speak more
about how data observability is ordered, while the barriers tend to
talk more about how the CPU orders operations.

Jason

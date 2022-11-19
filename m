Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB3A6308B6
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Nov 2022 02:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiKSBsY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 20:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiKSBsH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 20:48:07 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB2670183
        for <linux-rdma@vger.kernel.org>; Fri, 18 Nov 2022 17:20:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKIUtdrMfIfh8ns8fYAlKPEX8HjjWu51Pkjx5u3Xd3NSm6y6BTA1W099syA7GdR3wWX/cBw3AisbavqhjMitN3KEph+sPzM3aVViSCMl60GeUMuAPRXvXd3ydHpNCCCaoQoRiMKgG4HaETmCDFufm7JGGQXnTFcDPCpo7KtZM908rFety/khdM0g5I/F8w6F/PQg3wBoVvcrzlkVSNbAmaGSnnBhztqET0uecvdLADgrdAaWC+O3+oGJfoa5vTPsxBdHe3E/tNvlsRHxhBsd3f5bsYZSjMWxOC5J6VTxG+WvDfAcdNCKNB1MOJejK3f4aEaYoQRGpYGW4AodVKk3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0oClBkz4rWNg6HEVUaUzUozE7mX6cVs+VtxjQ/Qvfk=;
 b=buP2jL6qS1wvJoep085brR+iMDvjIWr4Ji49T6FHYdRIqTZAzXw+jSL+iQh11cLNl61TEt+CCDt9Gv9rVPD7sU6vGSQqQpi3wFlzEWqhUglUcvwuD+uzsUd+S5IX9W62leyhi+vOsLClQJKjCsSeL66PtE9m9kyy+bIn4y1LaF8YLvd8Yy7IlYEYGrG+OCEhxpb0OBD5WP1bfan90HyM7AhibkQtfW5aFmrER5ScYWKf53ytSSh7wPTDoEPllTD34wbi9xT09wXQ8wIr3+5uPiRDMMSTK5jCmKD0s6kmhJ00HlpQ8hQzTg4oqNuwYEz23rTUVDbSIFGM8NRWAm4eqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0oClBkz4rWNg6HEVUaUzUozE7mX6cVs+VtxjQ/Qvfk=;
 b=bUo+8dvdfMuPBQQsZqfmSnK9QzYRNPdtn1BoK0Fs/HFMUJOI7PEgoUTGvZFdroo8EuGB7wPo4pn8yXU9660pmnkK4KqR9xi05z17+buvDJegYI5HO14b82xlJLlKOL183K1hZQ6RyIrEZA4KGnl52JBEQojqS0lYBn0Ksa2Ai3YUQblaHLenb11r/2jar9NSWNRDV5XSn46F4GYTNMkJ94aJlnIh/GxPY4RNwtVS+Eg67RtiDtSMCo+NKXHipZcoRk3YUOL96SBXTRPE9lowaWmcspbyC13WSuTGN+bo9yY69jg8Sv75R+MH3q2FCHntwRnye3fxJ4G3Bbi3KoesbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Sat, 19 Nov
 2022 01:20:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Sat, 19 Nov 2022
 01:20:39 +0000
Date:   Fri, 18 Nov 2022 21:20:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     ira.weiny@intel.com, linyunsheng@huawei.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Remove struct rxe_phys_buf
Message-ID: <Y3gvZr6/NCii9Avy@nvidia.com>
References: <1668153085-15-1-git-send-email-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668153085-15-1-git-send-email-yangx.jy@fujitsu.com>
X-ClientProxiedBy: BL0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:208:91::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5306:EE_
X-MS-Office365-Filtering-Correlation-Id: 5464716b-58d1-4c42-d8b2-08dac9cc4521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bx2eaPdcTV722Cc3fx0wQIETY3SS8zsy0JqY3RZXoWHmdThmvhM76p5soNtW/i2yLrzOReRwSf9CCK1v68iwwqOW0EaXu48b2M58ElDFkzDkiFEKCTun5Pue5bJDl9GFD2hSRdjT4P8ktxCBqsuZA6A9lscOdsl+/9GvecUOygmIKNu2i3Gi3r2yHWEX8dvAYDhPMR6BtKKwJ70nE3SpP8Fl2JrbrnFIpJ0d0Ms0GOS0ymtSCb6/bi0OXXWbo+zcdqf9CCV0AzFrSpQvm+z8zqLp/yNR94uM5iCMgdNHcXFvP4pA7gSuA5YgjtwCvlxbqmcKfneKW5Roz9pzfKYlpJJKz5f5jVcMbC0dMX9bH44i/EV9Bdw9zj0QBJ0/sn7bqDSlxRgqKqtjOg6Oc3U7tldltO7ynFw6uhfZTZP2Txrgb9bHjipchdOcSt4v4I3wxm7T1QNzv+7zKuiQwHmD6upXLEUebLtv7gXwPbMwij9utD7epEjvUr7oWCgeEO4ChjBRFJFQv4ejJYz6y0CswwlIHz8mzn59ngD0nwYFdEmchJTVsGwaprgsdqaZuOLyMdVAVFouExa7wQ63+xrfnD9PeYVV6QiaPKWtMx+NCNRXT2t9EZ0wG2lHGPY8VLWRHu/1QGx52W9b9tnKRnEVCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(2906002)(83380400001)(66476007)(2616005)(8676002)(66556008)(41300700001)(66946007)(86362001)(186003)(6506007)(6916009)(36756003)(30864003)(5660300002)(4326008)(38100700002)(26005)(45080400002)(6512007)(6486002)(316002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iPkxgsoC2FBV4fjH41fScHEqaigaJUv2mXcmvpG9HQ/mBALruyWf8Wf4HhP3?=
 =?us-ascii?Q?Ygf+fTjxu0UsCVY9jMMv4OcaN0MDvx8lOssYCCVOq/t0QrUaHX4esQzE6ui7?=
 =?us-ascii?Q?eL1DcE3BTmfNLEBa4kZD0efaIpdtTofyQqJRnUsMX9G6k8UxqKtqSxeRjSOc?=
 =?us-ascii?Q?kNjjJ+imY8SFoc2PKhQ+QE9GkNxf2UiMokGFEXoMKnemzJqT6m3Wj3HGYPAj?=
 =?us-ascii?Q?CfaXU22osPnCOgarlrhtPtihawhr5c29rY27Qm1S9nuEnjApEwttruK1P0pr?=
 =?us-ascii?Q?qT3wXQGO+9S+KJi4Yp0XHlhZF+zlmzuI0GHwoPM1Z6ycY3qPwJrMdHK+n9QR?=
 =?us-ascii?Q?FKwO+X49FbDmXcLsW5yyHcoPplme9zvfPoTnM3AcaWLtwM9NQYfWDxDMd8d5?=
 =?us-ascii?Q?2XKZJpR9Rbw2grS+qlr40wkNnkcswBFRr6QtScRjoDr7FLEnPUytN/MPdciF?=
 =?us-ascii?Q?jXOss5BkUAchy5+3szZiqtiWcqRxZRZ/RfW4pYpVNgZjKOpOzqLrwf75auPW?=
 =?us-ascii?Q?XZ8iHPKVu+SFthasuu1IrN1HrgdE0rJHN+Kme2LDJ0pJRomMfhu9SdlzLiFa?=
 =?us-ascii?Q?OpAjRyoXyyaMw8HsCcT2AuP/d8F7gJJPekcISoOaKrJpd6WKkS19Zj5ffNaO?=
 =?us-ascii?Q?+RIXU4jOW5y4Ej8XbZyk8/894rl82gvv61meyDS2huBlMHJqWQ9cqiNnoQbb?=
 =?us-ascii?Q?1Br25WN2/GHS99cbTs6eq5eWvMhGT3GGuVWy4FCKUieA8PeZM84ElO5P9swq?=
 =?us-ascii?Q?qiGGOPkAhQWxgrlJVVLamLkg0QhaQ9tGSOCELpnv2Za+WCMZVaRU7R6YTtJd?=
 =?us-ascii?Q?3FqeR/+YoX/ExGrOYLKPiZoeyfMA8DFSeNG+OM9BDc0u4h/jW180DEql6eix?=
 =?us-ascii?Q?X9ayo0HxjKGRsKziyyGjSfQGFYnchvwim93NOO2B1Y4azDkLM67zretuR8LD?=
 =?us-ascii?Q?noJ08OYf+5FBNEcW9wuoGYeGisebdDieBOuSUfCf30ZnZHU9TBjEt09W2ngt?=
 =?us-ascii?Q?Sn8YWaRBy0KUyVYmMYX0dZ7N/xi1Um2OHDrm+Aj9HvTx7j5uZhAMXlYFls+X?=
 =?us-ascii?Q?17wpmlkKlU5KxLJ9rBXMVLGhT0JeOT3KCa4yDkteRb30uisPAMut2aiqGe+M?=
 =?us-ascii?Q?JkS5WB21DKL4gkG7er6LyD/Cyhc0vTcQND8TfRtfDJfppVYvy29l5EVG0JZP?=
 =?us-ascii?Q?C50eZVuXRri58o+1QNn39qsOunJa9j4MPvH0C6lHuvIGUznY/TqR/ED6LG0m?=
 =?us-ascii?Q?fPlUEsBg9s+MORWD53tYzD+nT2vuEElJMQfCEZaRSAlrRkhrQpIN8ROZXZd4?=
 =?us-ascii?Q?6Pfv46CCU7SDtYBTgM+e2//wdS6Btqd7ok9AueB2Jju4DEew+kEAvKhtNbbU?=
 =?us-ascii?Q?iskW3CjKBWIZluwRdwC+7isODBb4lnDrUc2bga35m0P7kG3M/hIAY/liEadB?=
 =?us-ascii?Q?f23cJH9hAK0VWwTstnaH7OhZhN91WGATRlmbbikQhjc+jzilx4niuxx3Dog1?=
 =?us-ascii?Q?hyv50yFRXi6ZtenxHhvDCffpkNs/setmdTQb15JQfgNeyq6b5Y9KrZKpbFoU?=
 =?us-ascii?Q?38sF7RY1X4phDEPDRXc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5464716b-58d1-4c42-d8b2-08dac9cc4521
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2022 01:20:39.8266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWid0a+4tRLqMtfAqGl7L+W/M3RbEN9IBY6iZBGrwTF4FBMmkprOpLKdhwNAPuDA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 11, 2022 at 07:51:24AM +0000, Xiao Yang wrote:
> 1) Remove rxe_phys_buf[n].size by using ibmr.page_size.
> 2) Replace rxe_phys_buf[n].buf with addrs[n].

This almost certainly doesn't work, but here is a general sketch how
all of this really should look:

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index a22476d27b3843..7539cf3e00db55 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -68,7 +68,6 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
-void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index b1423000e4bcda..7cd76f0213c265 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -65,41 +65,23 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 
 static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
 {
-	int i;
-	int num_map;
-	struct rxe_map **map = mr->map;
+	XA_STATE(xas, &mr->pages, 0);
+	int i = 0;
 
-	num_map = (num_buf + RXE_BUF_PER_MAP - 1) / RXE_BUF_PER_MAP;
+	xa_init(&mr->pages);
 
-	mr->map = kmalloc_array(num_map, sizeof(*map), GFP_KERNEL);
-	if (!mr->map)
-		goto err1;
-
-	for (i = 0; i < num_map; i++) {
-		mr->map[i] = kmalloc(sizeof(**map), GFP_KERNEL);
-		if (!mr->map[i])
-			goto err2;
-	}
-
-	BUILD_BUG_ON(!is_power_of_2(RXE_BUF_PER_MAP));
-
-	mr->map_shift = ilog2(RXE_BUF_PER_MAP);
-	mr->map_mask = RXE_BUF_PER_MAP - 1;
-
-	mr->num_buf = num_buf;
-	mr->num_map = num_map;
-	mr->max_buf = num_map * RXE_BUF_PER_MAP;
-
-	return 0;
-
-err2:
-	for (i--; i >= 0; i--)
-		kfree(mr->map[i]);
-
-	kfree(mr->map);
-	mr->map = NULL;
-err1:
-	return -ENOMEM;
+	do {
+		xas_lock(&xas);
+		while (i != num_buf) {
+			xas_store(&xas, XA_ZERO_ENTRY);
+			if (xas_error(&xas))
+				break;
+			xas_next(&xas);
+			i++;
+		}
+		xas_unlock(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
+	return xas_error(&xas);
 }
 
 void rxe_mr_init_dma(int access, struct rxe_mr *mr)
@@ -111,75 +93,66 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr)
 	mr->ibmr.type = IB_MR_TYPE_DMA;
 }
 
+static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
+{
+	XA_STATE(xas, &mr->pages, 0);
+	struct sg_page_iter sg_iter;
+
+	__sg_page_iter_start(&sg_iter, sgt->sgl, sgt->orig_nents, 0);
+	if (!__sg_page_iter_next(&sg_iter))
+		return 0;
+	do {
+		xas_lock(&xas);
+		while (true) {
+			if (xas.xa_index &&
+			    WARN_ON(sg_iter.sg_pgoffset % PAGE_SIZE)) {
+				xas_set_err(&xas, -EINVAL);
+				break;
+			}
+			xas_store(&xas, sg_page_iter_page(&sg_iter));
+			if (xas_error(&xas))
+				break;
+			xas_next(&xas);
+			if (!__sg_page_iter_next(&sg_iter))
+				break;
+		}
+		xas_unlock(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
+
+	return xas_error(&xas);
+}
+
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr)
 {
-	struct rxe_map		**map;
-	struct rxe_phys_buf	*buf = NULL;
-	struct ib_umem		*umem;
-	struct sg_page_iter	sg_iter;
-	int			num_buf;
-	void			*vaddr;
+	struct ib_umem *umem;
 	int err;
 
+	xa_init(&mr->pages);
+
 	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
 	if (IS_ERR(umem)) {
 		rxe_dbg_mr(mr, "Unable to pin memory region err = %d\n",
 			(int)PTR_ERR(umem));
-		err = PTR_ERR(umem);
-		goto err_out;
-	}
-
-	num_buf = ib_umem_num_pages(umem);
-
-	rxe_mr_init(access, mr);
-
-	err = rxe_mr_alloc(mr, num_buf);
-	if (err) {
-		rxe_dbg_mr(mr, "Unable to allocate memory for map\n");
-		goto err_release_umem;
+		return PTR_ERR(umem);
 	}
 
 	mr->page_shift = PAGE_SHIFT;
 	mr->page_mask = PAGE_SIZE - 1;
+	err = rxe_mr_fill_pages_from_sgt(mr, &umem->sgt_append.sgt);
+	if (err)
+		goto err_release_umem;
 
-	num_buf			= 0;
-	map = mr->map;
-	if (length > 0) {
-		buf = map[0]->buf;
-
-		for_each_sgtable_page (&umem->sgt_append.sgt, &sg_iter, 0) {
-			if (num_buf >= RXE_BUF_PER_MAP) {
-				map++;
-				buf = map[0]->buf;
-				num_buf = 0;
-			}
-
-			vaddr = page_address(sg_page_iter_page(&sg_iter));
-			if (!vaddr) {
-				rxe_dbg_mr(mr, "Unable to get virtual address\n");
-				err = -ENOMEM;
-				goto err_release_umem;
-			}
-			buf->addr = (uintptr_t)vaddr;
-			buf->size = PAGE_SIZE;
-			num_buf++;
-			buf++;
-
-		}
-	}
-
+	rxe_mr_init(access, mr);
 	mr->umem = umem;
 	mr->access = access;
 	mr->offset = ib_umem_offset(umem);
 	mr->state = RXE_MR_STATE_VALID;
 	mr->ibmr.type = IB_MR_TYPE_USER;
-
 	return 0;
 
 err_release_umem:
 	ib_umem_release(umem);
-err_out:
 	return err;
 }
 
@@ -204,77 +177,44 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 	return err;
 }
 
-static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
-			size_t *offset_out)
+static int rxe_mr_copy_xarray(struct rxe_mr *mr, void *mem,
+			      unsigned long start_index,
+			      unsigned int start_offset, unsigned int length,
+			      enum rxe_mr_copy_dir dir)
 {
-	size_t offset = iova - mr->ibmr.iova + mr->offset;
-	int			map_index;
-	int			buf_index;
-	u64			length;
-
-	if (likely(mr->page_shift)) {
-		*offset_out = offset & mr->page_mask;
-		offset >>= mr->page_shift;
-		*n_out = offset & mr->map_mask;
-		*m_out = offset >> mr->map_shift;
-	} else {
-		map_index = 0;
-		buf_index = 0;
-
-		length = mr->map[map_index]->buf[buf_index].size;
-
-		while (offset >= length) {
-			offset -= length;
-			buf_index++;
-
-			if (buf_index == RXE_BUF_PER_MAP) {
-				map_index++;
-				buf_index = 0;
-			}
-			length = mr->map[map_index]->buf[buf_index].size;
-		}
+	XA_STATE(xas, &mr->pages, start_index);
+	struct page *entry;
 
-		*m_out = map_index;
-		*n_out = buf_index;
-		*offset_out = offset;
-	}
-}
+	rcu_read_lock();
+	while (length) {
+		unsigned int nbytes;
+		void *vpage;
 
-void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
-{
-	size_t offset;
-	int m, n;
-	void *addr;
-
-	if (mr->state != RXE_MR_STATE_VALID) {
-		rxe_dbg_mr(mr, "Not in valid state\n");
-		addr = NULL;
-		goto out;
-	}
+		entry = xas_next(&xas);
+		if (xas_retry(&xas, entry))
+			continue;
 
-	if (!mr->map) {
-		addr = (void *)(uintptr_t)iova;
-		goto out;
-	}
+		/* Walked pass the end of the array */
+		if (WARN_ON(!entry)) {
+			rcu_read_unlock();
+			return -1;
+		}
 
-	if (mr_check_range(mr, iova, length)) {
-		rxe_dbg_mr(mr, "Range violation\n");
-		addr = NULL;
-		goto out;
-	}
+		nbytes = min_t(unsigned int, length, PAGE_SIZE - start_offset);
 
-	lookup_iova(mr, iova, &m, &n, &offset);
+		vpage = kmap_local_page(entry);
+		if (dir == RXE_FROM_MR_OBJ)
+			memcpy(mem, vpage + start_offset, nbytes);
+		else
+			memcpy(vpage + start_offset, mem, nbytes);
+		kunmap_local(vpage);
 
-	if (offset + length > mr->map[m]->buf[n].size) {
-		rxe_dbg_mr(mr, "Crosses page boundary\n");
-		addr = NULL;
-		goto out;
+		mem += nbytes;
+		start_offset = 0;
+		length -= nbytes;
 	}
-
-	addr = (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
-
-out:
-	return addr;
+	rcu_read_unlock();
+	return 0;
 }
 
 /* copy data from a range (vaddr, vaddr+length-1) to or from
@@ -283,75 +223,9 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir)
 {
-	int			err;
-	int			bytes;
-	u8			*va;
-	struct rxe_map		**map;
-	struct rxe_phys_buf	*buf;
-	int			m;
-	int			i;
-	size_t			offset;
-
-	if (length == 0)
-		return 0;
-
-	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
-		u8 *src, *dest;
-
-		src = (dir == RXE_TO_MR_OBJ) ? addr : ((void *)(uintptr_t)iova);
-
-		dest = (dir == RXE_TO_MR_OBJ) ? ((void *)(uintptr_t)iova) : addr;
-
-		memcpy(dest, src, length);
-
-		return 0;
-	}
-
-	WARN_ON_ONCE(!mr->map);
-
-	err = mr_check_range(mr, iova, length);
-	if (err) {
-		err = -EFAULT;
-		goto err1;
-	}
-
-	lookup_iova(mr, iova, &m, &i, &offset);
-
-	map = mr->map + m;
-	buf	= map[0]->buf + i;
-
-	while (length > 0) {
-		u8 *src, *dest;
-
-		va	= (u8 *)(uintptr_t)buf->addr + offset;
-		src = (dir == RXE_TO_MR_OBJ) ? addr : va;
-		dest = (dir == RXE_TO_MR_OBJ) ? va : addr;
-
-		bytes	= buf->size - offset;
-
-		if (bytes > length)
-			bytes = length;
-
-		memcpy(dest, src, bytes);
-
-		length	-= bytes;
-		addr	+= bytes;
-
-		offset	= 0;
-		buf++;
-		i++;
-
-		if (i == RXE_BUF_PER_MAP) {
-			i = 0;
-			map++;
-			buf = map[0]->buf;
-		}
-	}
-
-	return 0;
-
-err1:
-	return err;
+	/* FIXME: Check that IOVA & length are valid, permissions, etc */
+	return rxe_mr_copy_xarray(mr, addr, rxe_mr_iova_to_index(iova),
+				  iova % PAGE_SIZE, length, dir);
 }
 
 /* copy data in or out of a wqe, i.e. sg list
@@ -609,15 +483,9 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 void rxe_mr_cleanup(struct rxe_pool_elem *elem)
 {
 	struct rxe_mr *mr = container_of(elem, typeof(*mr), elem);
-	int i;
 
 	rxe_put(mr_pd(mr));
 	ib_umem_release(mr->umem);
 
-	if (mr->map) {
-		for (i = 0; i < mr->num_map; i++)
-			kfree(mr->map[i]);
-
-		kfree(mr->map);
-	}
+	xa_destroy(&mr->pages);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 6761bcd1d4d8f7..c1ed200e797779 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -631,22 +631,30 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 	}
 
 	if (!res->replay) {
+		u64 iova = qp->resp.va + qp->resp.offset;
+		unsigned int page_offset = iova % PAGE_SIZE;
+		struct page *page;
+
 		if (mr->state != RXE_MR_STATE_VALID) {
 			ret = RESPST_ERR_RKEY_VIOLATION;
 			goto out;
 		}
 
-		vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset,
-					sizeof(u64));
-
 		/* check vaddr is 8 bytes aligned. */
-		if (!vaddr || (uintptr_t)vaddr & 7) {
+		if (iova & 7) {
 			ret = RESPST_ERR_MISALIGNED_ATOMIC;
 			goto out;
 		}
 
+		/*
+		 * FIXME: Need to ensure the xarray isn't changing while
+		 * this is happening
+		 */
+		page = xa_load(&mr->pages, rxe_mr_iova_to_index(iova));
+
+		vaddr = kmap_local_page(page);
 		spin_lock_bh(&atomic_ops_lock);
-		res->atomic.orig_val = value = *vaddr;
+		res->atomic.orig_val = value = *(vaddr + page_offset);
 
 		if (pkt->opcode == IB_OPCODE_RC_COMPARE_SWAP) {
 			if (value == atmeth_comp(pkt))
@@ -655,8 +663,9 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 			value += atmeth_swap_add(pkt);
 		}
 
-		*vaddr = value;
+		*(vaddr + page_offset) = value;
 		spin_unlock_bh(&atomic_ops_lock);
+		kunmap_local(vaddr);
 
 		qp->resp.msn++;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 025b35bf014e2a..092994a0ec947a 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -948,23 +948,44 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	return ERR_PTR(err);
 }
 
-static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
+static int rxe_mr_fill_pages_from_sgl_prefix(struct rxe_mr *mr,
+					     struct scatterlist *sgl,
+					     unsigned int sg_nents,
+					     unsigned int *sg_offset)
 {
-	struct rxe_mr *mr = to_rmr(ibmr);
-	struct rxe_map *map;
-	struct rxe_phys_buf *buf;
-
-	if (unlikely(mr->nbuf == mr->num_buf))
-		return -ENOMEM;
-
-	map = mr->map[mr->nbuf / RXE_BUF_PER_MAP];
-	buf = &map->buf[mr->nbuf % RXE_BUF_PER_MAP];
+	XA_STATE(xas, &mr->pages, 0);
+	struct sg_page_iter sg_iter;
+	struct scatterlist *cur_sg;
+	unsigned int done_sg = 1;
 
-	buf->addr = addr;
-	buf->size = ibmr->page_size;
-	mr->nbuf++;
+	__sg_page_iter_start(&sg_iter, sgl, sg_nents, *sg_offset);
+	if (!__sg_page_iter_next(&sg_iter))
+		return 0;
+	cur_sg = sg_iter.sg;
+	do {
+		xas_lock(&xas);
+		while (true) {
+			if (xas.xa_index && sg_iter.sg_pgoffset % PAGE_SIZE) {
+				*sg_offset = sg_iter.sg_pgoffset;
+				break;
+			}
+			xas_store(&xas, sg_page_iter_page(&sg_iter));
+			if (xas_error(&xas))
+				break;
+			xas_next(&xas);
+			if (!__sg_page_iter_next(&sg_iter))
+				break;
+			if (cur_sg != sg_iter.sg) {
+				done_sg++;
+				cur_sg = sg_iter.sg;
+			}
+		}
+		xas_unlock(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
 
-	return 0;
+	if (xas_error(&xas))
+		return xas_error(&xas);
+	return done_sg;
 }
 
 static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
@@ -974,8 +995,7 @@ static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 	int n;
 
 	mr->nbuf = 0;
-
-	n = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_set_page);
+	n = rxe_mr_fill_pages_from_sgl_prefix(mr, sg, sg_nents, sg_offset);
 
 	mr->page_shift = ilog2(ibmr->page_size);
 	mr->page_mask = ibmr->page_size - 1;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 22a299b0a9f0a8..6eebbd7b91a687 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -320,7 +320,7 @@ struct rxe_mr {
 
 	atomic_t		num_mw;
 
-	struct rxe_map		**map;
+	struct xarray		pages;
 };
 
 enum rxe_mw_state {

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5D146BC39
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 14:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhLGNSX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 08:18:23 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32946 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230153AbhLGNSW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Dec 2021 08:18:22 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7CgLhO004042;
        Tue, 7 Dec 2021 13:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=6t4NdUva94sDslHrmosQ126aeDf2c82kYS0Fge9kvyE=;
 b=jGJa78qwlNuBpB3GSQtbKJhWyUq3S5Irq/36Jbs/5zBgByUuGsF8E8CIXZIcLeOaH3wX
 5eaef1D3SgkZiOcS99JtO68KkHooYkch0zZoeEnG5zXhWhn7gqVNu2yBxo5EI4xEUU/A
 L1QZUeU7UTAKd9YDrcdzNvuT0sDzjn+7ezl9aAUaHRpnFnBuShgqw8ei9waPeMq3cBli
 MoyNIa8Emnknq/RawYFKCcoK+iXTrQciQfIbhJAngUW+FObbmb9kQUNC9g377sQ7RxW8
 9CilKlA8d7arx3JKQaEGk0KbXIirwzI4Y/TDIUx4z1Er5FRc0Dxxm2VUmFmRJTZ8o+vz rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cscwcdgha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 13:14:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7DBF56045587;
        Tue, 7 Dec 2021 13:14:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by aserp3030.oracle.com with ESMTP id 3csc4t8932-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 13:14:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bgs55loCBLWYgy74+10lPxPmoU/ICMntU6IpdII1AeAJIsZhkHzyxvI6SM5eAIl2YPD6XYdmxwSHioWWIq1W+5esvh80+CgtBakxQQC9nn4APV/l/x1kfLdlEcd0aF+BSiAl9jsQEz2jZrFUA7kBbO6c9qBScYLti0b8b4jDiGUGsN/PClmzzbINQoM7G8z3vS9nDyHF7O4wDUbijTzCsniXRNNAP/eeDkQo8tn03RPQm0w9LhBzxu9VpIJLmgO5eSxV/vYW5pXTszOOuBwpmZtxXTj5ELqknuEb/pR7QXi2xF2Ld6fkFcZDCIbXFZRI/Tl+lL79grP5McpR0gqTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6t4NdUva94sDslHrmosQ126aeDf2c82kYS0Fge9kvyE=;
 b=XZrMZGBdvTDNU9w/p4W3tk+8DTzM9YrJOXnB7gS4KxXR2AML8Pfs5XbEI8FWcXW3oBQIGhSMtkNj8Ymo6UWGTDcb7/26SJDW0Rlq4tuUVvkfwzXj58HV1Gdo3mbBOcI4WeHN7zq7LgS+fX8brgFnWGGB1yn18fEMECSiHYZYExIW57EqkJlWUM9o080e1+kCNvLJ+XIsiK7nbwKr5COuhoUlPRPe1dBBxRgvxxJS3yL3FgAwXKllrtGDJ2fbhgNIwOAI7BrKkvLdp+VEZTy48OjBRFzvRrntSY/BDko/UnNZBWImo1VDYa2fzmCseTrRoCkevEB0o3brzcqS9FiSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6t4NdUva94sDslHrmosQ126aeDf2c82kYS0Fge9kvyE=;
 b=QzzfuiGYyUsD7YbTNnzYUf69cX3QvJkw+mMF8P06JbDmMT0hI/RwDJiJ8IkC+fMo5VAMfbkCE4B39tx6el1bjfKhu+tIbIXNvFh7FaRMHUDpEbqPTYcvlTCCUEQ5Wf39S5llM1XEs0mV1tv8ty+D0HhWGWFXkxyhHm3jq371Shw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2096.namprd10.prod.outlook.com
 (2603:10b6:301:2c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Tue, 7 Dec
 2021 13:14:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.023; Tue, 7 Dec 2021
 13:14:48 +0000
Date:   Tue, 7 Dec 2021 16:14:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Fix a potential memory allocation issue in
 'irdma_prm_add_pble_mem()'
Message-ID: <20211207131428.GF1956@kadam>
References: <5e670b640508e14b1869c3e8e4fb970d78cbe997.1638692171.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e670b640508e14b1869c3e8e4fb970d78cbe997.1638692171.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend Transport; Tue, 7 Dec 2021 13:14:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb4b135e-3022-4263-2055-08d9b9838b80
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2096:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB20966F96D17C3A2EBC2F2A378E6E9@MWHPR1001MB2096.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X6AYrCIkC5ufeFHKyhdlhKw4d1/i8730pt2szqLskGKqrr7+7Jr9Mr5jnLPsqgsO3uL3PxLjkHthqxSAowSwHEWR33iD11IL86xxpMBrCsdG2HP8APb6Cm/lcb7QpJcsLW0OcNf+pXn3I5lru3orBEIlg7jA+yOIBIfPMGYy+XwpfzLNVZcyolBHD4UbIuMdVlkVQVC2Ggvev0Gs9oOFgQQbOSLS4JA9E4b9BLG28kTjZpwaf1bRkCBCG+glWap51RLixBhR1h61o8MPNaD8dL8kWhVErPNHF6vbYk9Ula2mBsHsva+PUDJh6sqAsuooqyU3WWKsy5tGtLcDSUYn1LvBovVPnwUXcgUmb6Q+c68n/0oz8N6IufLAlq6YJ7EknuIxw7tKsLv1ESoaWDY2EIygTS0ThW3pdxHgqGxGOIISAQRw6AHW/6r9zSzKsChWQp82EQD6YX994/lvW1K8uly4cjxE9ZmnLCUYsg9D2XUycpg3NW05UWkclsvBO+OyR8M62305R9EIREzmNBm+4OZdclD7Khr7u2xIWy0/wK6K/CrkK4zqUO/s1wNLxMpCffyeajaI4mJPcWv+eauMWq4dNIdsyewVR0J7xnWfTnoJrslUgQaAPJ2gmjl5ulP1Bl08TNn8KmJ1MpJk0VsvTiRDf7Goa0UokdOBnKzeB1llv6avXaU44XwjT8NzpBCkiSeiySv02DoizfUjU9ULGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(1076003)(38100700002)(38350700002)(5660300002)(8936002)(8676002)(33716001)(6666004)(86362001)(66476007)(9576002)(66556008)(66946007)(6916009)(508600001)(33656002)(4326008)(2906002)(83380400001)(55016003)(186003)(52116002)(956004)(6496006)(44832011)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0kQ2Iv0WZZGRk/MGiIWEI4ictyAgXV4pyhzb99vFlCH0PpuSFsDhDmVi/LWN?=
 =?us-ascii?Q?K/wixw1B6RBlbL9n3cVrnRoKk0aLDVVUpPV45flUVX/XGU0ZZ/jbfT0GdsRi?=
 =?us-ascii?Q?rk0PhW4QAvIkT5eZkRzSGfGiVz4y3R6FJ9OSJtgcMaRck7I6bV2Q1noRa08P?=
 =?us-ascii?Q?HKeIEF9hKOJpuwxBPqTH1TbI1cVAGWKe9h+haNL8Z9VNpm/GmD5THgr4c9Wh?=
 =?us-ascii?Q?lbljRSzLkggeKZ+sGjK0w/NITG3l/8bK7CCdVy7nbMbNpVvefaE+iEuoEt50?=
 =?us-ascii?Q?GEZ+ITxdbSQX8NhWTGhj9K86SjZoMn82g8U0gobYm4PRUkcdosY5Mp1kffBL?=
 =?us-ascii?Q?zlyKj2J/lCRU376C+N/MPb2qc6Zt5BblIax749eeTfGqbpiAWR/gSZxlPWF2?=
 =?us-ascii?Q?48w2gpcvQ6dR3DhUkPMA5gVwUS2x4ZNXvCq/+DlzsaAmutK0LPxxHvdLDpym?=
 =?us-ascii?Q?Ku/Mg00KG+ydw172cVj7ysIid5VUGtSUn6BnMNRb+WCoG/uzYUBdZHy7TYrb?=
 =?us-ascii?Q?jgdV1NJpdwLo2P41BOdj3UcYSEmqSPAdbQT3L6GtKRP6DgP6OgoI+lhWEURU?=
 =?us-ascii?Q?0p4YIXDAO64fuzL/WsYgUoYwcTbW74pZSloKiuliqktsyJ7Kmz68eL635P05?=
 =?us-ascii?Q?Ec7QF98FO3xTA+DZ9LioN1TAsOoTjnZnyDwQZ3dkNSVw8bVCINrbCCcT9pZs?=
 =?us-ascii?Q?M+LUHVEsulQZymoO44dohprqGydXSzLiig+IPpbxA1E353tALLOQ0OauBDQ9?=
 =?us-ascii?Q?D5Cg2VULrdOstpMCcD5DpYKibrdd7koaeF/QYLJmw/Ej7+kDFaVW002J+0Dx?=
 =?us-ascii?Q?DerO5h5jXeDBigv4Ia78xQrco75s0PaQbrMKwR18W+qE0oNQKg2QAXfQHHEu?=
 =?us-ascii?Q?XECPvBmDcviYWTo+xblMVWJF/xg19tnIfPrucPZbzAR92JLbEOHHCGYbWzmz?=
 =?us-ascii?Q?DExzM3NXfUescpXtBJI0VqiJfh5WlZv5Hmvlv112sGHoRMZl5zLVT6v8Mobq?=
 =?us-ascii?Q?nSE2hTCRA+r+1Kl3QPTgQlxmk1clC6rYXIij20E7+KKgjOnNRoS+yiYssb6J?=
 =?us-ascii?Q?GXocGVwOTTGg4qVcnL8tR41TJX8DvCEH9VHR4oM7Eexftiv1GZo4CivsfJx9?=
 =?us-ascii?Q?bKQvkj4Q9MdeX21b5SZhLvq4SLSAnqxNbsFdD8Ilcuc/jr/l4MOUv3U7mKtt?=
 =?us-ascii?Q?S1aP6GPN2dh3iMCiwZFybPIe/bbJSYFcE8eoxXgBiaMiPvyy5NiDL1FpTsb1?=
 =?us-ascii?Q?x7kGiOIDIP7qr4iHf46PZSGJu7zV1GNQS6VeHEXqlpBmbpQ1oUasDuEz+v/S?=
 =?us-ascii?Q?qBP2IFqZAhKUYCpl3ApiHPA55pwmpeAvr3v5rV8CpeucPiPc+/Ivkb/pcQAn?=
 =?us-ascii?Q?jkRRV5VH8NjGDf8i3YD+dVsyA+9Q69C3Wow/1izuonHy0X0GuGsy5LQlybDb?=
 =?us-ascii?Q?Exil2eTNAgHuhwoDfAZJb2g1AT76XWrI8UY6iYX93cVd6ETuAp8ULUvTAGdh?=
 =?us-ascii?Q?jL+0rp+1gX5t6H8rJWW2404SHtgeLVzCAeL9ERS/LdBVp70nvNcN8aMTN4hC?=
 =?us-ascii?Q?MVR7BC04zAmVuy5RRNhXD6FwjvwtK9HhoF9dIr76FWo6OK8Pkh4lAGrj93uW?=
 =?us-ascii?Q?2sWIXKrG+sbEbp4E5W7WipDzRJ8Hv/J+rk6riksr4sbOcgjnqLQn2572cZah?=
 =?us-ascii?Q?WZbbrWKXPvZ2bvi8BXo+cBT0dGQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4b135e-3022-4263-2055-08d9b9838b80
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 13:14:48.7087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnXhdRbTTAMFrPTDk7zPtbFg+o89yNspYLNckmFv8Dkpp1v0UgRCl3K9SRp2oIMDczh0dja5BgvglTHGmUellGSgqGBWzXqVdzH2uFLrk8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2096
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=873
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070079
X-Proofpoint-ORIG-GUID: hmJdvsCJxstwoZhrydWHsjmKQ-9CghqM
X-Proofpoint-GUID: hmJdvsCJxstwoZhrydWHsjmKQ-9CghqM
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 05, 2021 at 09:17:24AM +0100, Christophe JAILLET wrote:
> @@ -299,8 +298,7 @@ add_pble_prm(struct irdma_hmc_pble_rsrc *pble_rsrc)
>  	return 0;
>  
>  error:
> -	if (chunk->bitmapbuf)
> -		kfree(chunk->bitmapmem.va);
> +	bitmap_free(chunk->bitmapbuf);
>  	kfree(chunk->chunkmem.va);

Thanks for removing the "chunk->bitmapbuf = chunk->bitmapmem.va;" stuff.
It was really confusing.  The kfree(chunk->chunkmem.va) is equivalent to
kfree(chunk).  A good rule of thumb is that when you have one error:
label to free everything then it's normally going to be buggy.

drivers/infiniband/hw/irdma/pble.c
   281          pble_rsrc->next_fpm_addr += chunk->size;
   282          ibdev_dbg(to_ibdev(dev),
   283                    "PBLE: next_fpm_addr = %llx chunk_size[%llu] = 0x%llx\n",
   284                    pble_rsrc->next_fpm_addr, chunk->size, chunk->size);
   285          pble_rsrc->unallocated_pble -= (u32)(chunk->size >> 3);
   286          list_add(&chunk->list, &pble_rsrc->pinfo.clist);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
"chunk" added to the "->pinfo.clist" list.

   287          sd_reg_val = (sd_entry_type == IRDMA_SD_TYPE_PAGED) ?
   288                               sd_entry->u.pd_table.pd_page_addr.pa :
   289                               sd_entry->u.bp.addr.pa;
   290  
   291          if (!sd_entry->valid) {
   292                  ret_code = irdma_hmc_sd_one(dev, hmc_info->hmc_fn_id, sd_reg_val,
   293                                              idx->sd_idx, sd_entry->entry_type, true);
   294                  if (ret_code)
   295                          goto error;
                                ^^^^^^^^^^^

   296          }
   297  
   298          sd_entry->valid = true;
   299          return 0;
   300  
   301  error:
   302          if (chunk->bitmapbuf)
   303                  kfree(chunk->bitmapmem.va);
   304          kfree(chunk->chunkmem.va);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^
kfree(chunk) will lead to a use after free because it's still on the
list.

   305  
   306          return ret_code;
   307  }

regards,
dan carpenter


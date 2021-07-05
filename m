Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C2D3BBB2E
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 12:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhGEK05 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jul 2021 06:26:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7038 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230355AbhGEK05 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jul 2021 06:26:57 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165AG2lR023847;
        Mon, 5 Jul 2021 10:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=XZeSdFfLCYeIFMztC3S/pFM/tQ+tCENIU/Vtz0jmk4Q=;
 b=fBbBElDLrGO18NxXgyHjaDL68T5caeTOs6fCbvQpEsG6DU0XGc3rDXXPwVVrY2Ll4Rue
 9cM5arT3AzEforQ2xzRYeXw7qenV5k7b27Uqg1ItXvJjLVqsnbznZLlxjlIcsxxr4gBV
 a9jebdYQwRXmKRo1s07pIdtyk1e+xQ2s02q6EgggoEJQiA9EgDxz8uqLld8IO6W1GEgU
 A+eOsUjoa+h3SA3U73Cp07QNg6OPoZmnKwZURH7GYeZaKo4svaWEo9wS3X+VJMKUF+C8
 yLXAWEA6RAkQ9Gz4zakLXsmpsDRDealeDmQlwhNI8O673aI/VE3EndYIWEuSiR/ugG0o Xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jeacjc82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 10:24:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 165AGBec019683;
        Mon, 5 Jul 2021 10:24:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3020.oracle.com with ESMTP id 39jfq6hs0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 10:24:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmHFcR0MPIcGM05hDvcDiUnbKG4V6n2ZtrphPxcYBY/H+1BA/KAj5O8oBDC2r6g55MuWDowjaUAzUm0/b1gDhCuxsH9HOeb1+04H6NuCY/ApNcUN/4CJRcPozULtK9MqTvE+OuVr200JXhe/Zil8kOxC3Atuuxg1YJV7vV6pRmfJ/dqg2K7duyxl6lbBazPc4nlxK8sX4kfKZbNqklnu2PqTz3Sug/AHAsFzW4aKLCfMvnOj34qTYE6fWHlHfN6cfrcvKx/X3nOxI5pWYlj8daj++pjT9SZ54kZ0h+97IBZYhnyAXNzLNw1t9Ehr2ALkV6FC6k2IPUAL9a2hYYzugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZeSdFfLCYeIFMztC3S/pFM/tQ+tCENIU/Vtz0jmk4Q=;
 b=Gy7/x6eJhX1iTByCcxu5QvJl+/IDt//Mx5dkfoj/E4gT8/rKvgUK0o2uiS85WP6QrtnHlWlA+hlQ9mupc9PQgID5HPN+ShiYdbVdGWvAJLBy93csG8o7MhM7EAc777s+XfrDKkyRILz/ZawGEZE3IoDJfYtQj48aa/zLDbI7KvA4+QO1ISGrScQLeWSpODGtek4CeaDHfWu5ozs4A8K7NKgYoIp52G7GUFa5UoCCmHcm2P3bEKfSh6UANe7hgPVf1s0gFF3WXSzcv1VuGwkJFAaqGdb4vALzyizq6bb29yD/Y3adH0oBUHhJi3sgMWr0p77IV6QHxu8wGVKBdgSCpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZeSdFfLCYeIFMztC3S/pFM/tQ+tCENIU/Vtz0jmk4Q=;
 b=J057HQ0PjIFE5+VZcyTBPwZS2zd1+b48j3sF8dXc7OzeE7c+inqchnz6gUGQC5LZaeSSn9ee2E/ULp4ThbmXZnrh+25IDz8tjUCaNWB9pNx3BcJwsksU6ecwmIBUH0Q2+nXwzNPugp6KpsJsC6wkVHm7o53cZSCd2qGr9eafY2E=
Authentication-Results: cisco.com; dkim=none (message not signed)
 header.d=none;cisco.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1616.namprd10.prod.outlook.com
 (2603:10b6:301:9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Mon, 5 Jul
 2021 10:24:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 10:24:15 +0000
Date:   Mon, 5 Jul 2021 13:23:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     umalhi@cisco.com
Cc:     iommu@lists.linux-foundation.org, linux-rdma@vger.kernel.org
Subject: [bug report] IB/usnic: Add Cisco VIC low-level hardware driver
Message-ID: <YOLdvTe4MJ4kS01z@mwanda>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Originating-IP: [102.222.70.252]
X-ClientProxiedBy: JNXP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mwanda (102.222.70.252) by JNXP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Mon, 5 Jul 2021 10:24:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9a3ed64-c575-489b-d0aa-08d93f9f09bf
X-MS-TrafficTypeDiagnostic: MWHPR10MB1616:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB161689CA63EE32FE1AE1E6EF8E1C9@MWHPR10MB1616.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXUipM9+zOqjy4mKl9gc5YFQNSu5ISTLvHTivLOiIZMseII+0Ls0RNCfJUU1ULK32TpnpwmsITWEKdzjlZkLlijFKVY1KqnFTv/4wEGM0Hylh44zaGxrwxvX0GuJi1DN8YhHXHJlDsOAZTGrnl0+IRd723UqCVmz5TkIyS4jnsVM5YDOB5PtTnDqvD5gRQIuycNfgi5VB5p5Xf5dQmUFpg/6JVp+X3NbT4n73ZFta5dw+oTjphju9cSBg6/B1P5HJk3U/0kWCwqWzanqtC9KKf/jpED9HeWvSwODRQLHNJ5pJk26vuqbOUDwziEVtisteg0WbYK1XK+gZPuE9jYqHSeKyc14Epku/EcGbDq8mepuJqjpdnQPoa2klxFp2i4vpp86fzGt0JPt++T8yCqUVRq+TxRG6N5K9/Rb2yN48/+AXZHnve4mYrqDEjh+QropGScjzY70ThgGJrFS9VxYPWibderoQeiQOx/OqaDtxloQXpuX/+12gWQ+yzlaIm1NRKlhz7mjjlplK8FCOJHraRmMxNqXNCR81fp4w76nGRuhi3tlqCdSS432FOi8ohmIVdsWYAR5uvg55GrDFIPmw3vAPNub23T+o4OFwLj8QLVKLaQ0c2znqqkuuzrGRMnsJqmyyuQJe8knlF2A2FW+yQwML+VzfVb0fqSTSuWLb9dPhwTPpmhov8MFhh1RMUrh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(33716001)(44832011)(8676002)(66556008)(52116002)(66946007)(6496006)(66476007)(83380400001)(6666004)(956004)(5660300002)(16526019)(478600001)(6916009)(316002)(38100700002)(38350700002)(86362001)(2906002)(26005)(9686003)(8936002)(186003)(4326008)(55016002)(9576002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/DF6n1mQRVFT2BqhjnmVorgRW9AZVS3LFle8pi/NMdVd0/EY7OpAmRwjQ/Pr?=
 =?us-ascii?Q?QeFgZrZtYAHS6N3ageFmx59MR+PQcear6bNv3GwK9qerWPDx6dsDOxCThAp3?=
 =?us-ascii?Q?raHIALRfZKrAiYwBbUlPlfbRhtVVtvMsqpq/mxLLsRaMDbpOSpSpq1eWD9jL?=
 =?us-ascii?Q?zxWqbgZrtec3/wg5jqyeUWPBR1ZTI0TOGWRqre9BZ7EKSaHrxhO9u9lGEQnc?=
 =?us-ascii?Q?CZSv653y1hBGYJHuV90lM/idf8S5as2wW776CVGl4BcndXPnZ1qrcod594Y1?=
 =?us-ascii?Q?2FjdIO5MqfPDL2om74fZsQj0dOFtvfxzFFJ9l632/ARIc7xlzaqqrCyqXlta?=
 =?us-ascii?Q?xfryv9jz1v26KnJCaEoIpNPyJMroOYiIL8BJplFQevAoA0eQgCWcBYKTpJt4?=
 =?us-ascii?Q?0S+ay5pw1yPjhj0zJ1PlQ88agvFF8EfgQwI/6lag7GhL7DrGNcTFw7VQ8HNQ?=
 =?us-ascii?Q?Mpr1xq8mBgAa0tc0a0ovpgOrmZ/khh99E2IKvYXRMVbfCrsxAkPZ2dt0QKHR?=
 =?us-ascii?Q?RvyXiIDtd4V/rpX24wrIdTZtPZiwHl8KsK8fqzO8SUcKLK4FWgng8pTwjbY0?=
 =?us-ascii?Q?EDeO5q/Er7TB8elMsPO9WtGBjQb2v30ykcPCx/Ihy6Ex2HkqZKlTzn5fgIJ1?=
 =?us-ascii?Q?R7D3HWK2gkoL14+rCvISSwSNH4YbI31asDpFLcgdYGkdKvm3IJE2En5c0htl?=
 =?us-ascii?Q?4la7+jofLFsHnC7g0b4TWcJa32AAMb0XW3PGgcZjyCxrhS5frA4l4h3KB8se?=
 =?us-ascii?Q?LCtPbO+EAF3/8Onqg2AgDegzuRQ9TxAFUAwI0hFNpBerC2SVZtEdjsXvsWRE?=
 =?us-ascii?Q?PnodlcM9BYjUSo8y3a3t4UB0zGDN4ryQ/aT8NiFAlBlnE6YA8YNNfAFNkhWv?=
 =?us-ascii?Q?EyXrh7ophIqxpFEv50kGm9y0dFshW2chbmp8CvLMqjgSt64JZoUnlpB88IIp?=
 =?us-ascii?Q?oxv+U0KaZzsyWd3ywI6TugkJQ/9wkNf6euXguhvY6zJKMHFfwe0LcIAFENde?=
 =?us-ascii?Q?HvB4LFa980slAMNadDLAXPfDzZKhLLHmQLxiqjJkZrp+ihNebugn2DXPh0zW?=
 =?us-ascii?Q?T2qj/XaIDIsiYsLfhgqtzTxmhHRZENk8WU29bULt2MRaotJ01fRNDRr+nAUF?=
 =?us-ascii?Q?5S9ZdqXApEafH+3sHCEm1X3vFTzj31j16Jp7oJMVs0Zp3Ihv9HUSKO1r9vJ/?=
 =?us-ascii?Q?OYc+yJygwpEg8PM2GbWpPzfFfCx+wzIVLIqlIw9Yd+UPJSIHCLupo9+58RPO?=
 =?us-ascii?Q?OF1NBfW7WjahiDum1ExPI1J9N9izz/O1+gb0S/DP2u4fSBqWfgLYcKpfYBMA?=
 =?us-ascii?Q?mL1kSFttLN833tNRvRomIxKJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a3ed64-c575-489b-d0aa-08d93f9f09bf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 10:24:14.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTgMf8xP1KoABuPIpUNDWPMo3WPTwQSCiVngv0FOT7xNcFMkPp01dbxQtKs6779wfJRyIirMCPV3zxucJlkJPsVT8qO67fInJcOCQU9MEUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1616
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10035 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107050055
X-Proofpoint-GUID: 353zQFG3ONCmQeqxmS6Ft9ilpzblh9Sl
X-Proofpoint-ORIG-GUID: 353zQFG3ONCmQeqxmS6Ft9ilpzblh9Sl
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[ Ancient code, but the bug seems real enough still.  -dan ]

Hello Upinder Malhi,

The patch e3cf00d0a87f: "IB/usnic: Add Cisco VIC low-level hardware
driver" from Sep 10, 2013, leads to the following static checker
warning:

	drivers/iommu/iommu.c:2482 iommu_map()
	warn: sleeping in atomic context

drivers/infiniband/hw/usnic/usnic_uiom.c
   244  static int usnic_uiom_map_sorted_intervals(struct list_head *intervals,
   245                                                  struct usnic_uiom_reg *uiomr)

This function is always called from usnic_uiom_reg_get() which is holding
spin_lock(&pd->lock); so it can't sleep.

   246  {
   247          int i, err;
   248          size_t size;
   249          struct usnic_uiom_chunk *chunk;
   250          struct usnic_uiom_interval_node *interval_node;
   251          dma_addr_t pa;
   252          dma_addr_t pa_start = 0;
   253          dma_addr_t pa_end = 0;
   254          long int va_start = -EINVAL;
   255          struct usnic_uiom_pd *pd = uiomr->pd;
   256          long int va = uiomr->va & PAGE_MASK;
   257          int flags = IOMMU_READ | IOMMU_CACHE;
   258  
   259          flags |= (uiomr->writable) ? IOMMU_WRITE : 0;
   260          chunk = list_first_entry(&uiomr->chunk_list, struct usnic_uiom_chunk,
   261                                                                          list);
   262          list_for_each_entry(interval_node, intervals, link) {
   263  iter_chunk:
   264                  for (i = 0; i < chunk->nents; i++, va += PAGE_SIZE) {
   265                          pa = sg_phys(&chunk->page_list[i]);
   266                          if ((va >> PAGE_SHIFT) < interval_node->start)
   267                                  continue;
   268  
   269                          if ((va >> PAGE_SHIFT) == interval_node->start) {
   270                                  /* First page of the interval */
   271                                  va_start = va;
   272                                  pa_start = pa;
   273                                  pa_end = pa;
   274                          }
   275  
   276                          WARN_ON(va_start == -EINVAL);
   277  
   278                          if ((pa_end + PAGE_SIZE != pa) &&
   279                                          (pa != pa_start)) {
   280                                  /* PAs are not contiguous */
   281                                  size = pa_end - pa_start + PAGE_SIZE;
   282                                  usnic_dbg("va 0x%lx pa %pa size 0x%zx flags 0x%x",
   283                                          va_start, &pa_start, size, flags);
   284                                  err = iommu_map(pd->domain, va_start, pa_start,
   285                                                          size, flags);

The iommu_map() function sleeps.

   286                                  if (err) {
   287                                          usnic_err("Failed to map va 0x%lx pa %pa size 0x%zx with err %d\n",
   288                                                  va_start, &pa_start, size, err);
   289                                          goto err_out;
   290                                  }
   291                                  va_start = va;
   292                                  pa_start = pa;
   293                                  pa_end = pa;
   294                          }
   295  
   296                          if ((va >> PAGE_SHIFT) == interval_node->last) {
   297                                  /* Last page of the interval */
   298                                  size = pa - pa_start + PAGE_SIZE;
   299                                  usnic_dbg("va 0x%lx pa %pa size 0x%zx flags 0x%x\n",
   300                                          va_start, &pa_start, size, flags);
   301                                  err = iommu_map(pd->domain, va_start, pa_start,
   302                                                  size, flags);

iommu_map() again.

   303                                  if (err) {
   304                                          usnic_err("Failed to map va 0x%lx pa %pa size 0x%zx with err %d\n",
   305                                                  va_start, &pa_start, size, err);
   306                                          goto err_out;
   307                                  }
   308                                  break;
   309                          }
   310  
   311                          if (pa != pa_start)
   312                                  pa_end += PAGE_SIZE;
   313                  }
   314  
   315                  if (i == chunk->nents) {
   316                          /*
   317                           * Hit last entry of the chunk,
   318                           * hence advance to next chunk
   319                           */
   320                          chunk = list_first_entry(&chunk->list,
   321                                                          struct usnic_uiom_chunk,
   322                                                          list);
   323                          goto iter_chunk;
   324                  }
   325          }
   326  
   327          return 0;
   328  
   329  err_out:
   330          usnic_uiom_unmap_sorted_intervals(intervals, pd);
   331          return err;
   332  }

regards,
dan carpenter

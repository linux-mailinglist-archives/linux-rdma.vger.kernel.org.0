Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385B035DCD9
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 12:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbhDMKx1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 06:53:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60434 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbhDMKxZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Apr 2021 06:53:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DAj80k182142;
        Tue, 13 Apr 2021 10:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=HxtGILvF4bCSLkJghz5x9ANVcSq2lO/lCluMdllKMIw=;
 b=YwAyp+ANL7NSqFVKFAenTi448VvIrTZbsLqZK7b1/BjNSs7YN0WiGw0S9u8DvFyPvDHg
 WXSQpmXMCJsQCqMhJCoEZKr4XQ+RKQ9TFB0o8d+P65oGgZ3JPAw61SJWdfgnl6yi3opq
 QpeweTVha5LLfO0cSJiTdC2yZEZ/TkD68NANdnB1qZ41auhIsBNlMsKfmPD7wQDgEoAk
 c7cz8BeGTlf7bsubXTbpD1dy8YjcgaN8huzc/ySnE0WWylMxDusDkL6iQ3aw9NPRimmn
 Ad6lMJ0K1744EM4K3W5/8T6GAZHbWOpTD8haZoyLpDDOTFlFkeaRCC1RMoB2dkfoNStU yA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37u4nnekus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 10:53:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DAoSNB089255;
        Tue, 13 Apr 2021 10:53:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 37unkpc046-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 10:53:03 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13DAr2Qa007825;
        Tue, 13 Apr 2021 10:53:02 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Apr 2021 03:53:01 -0700
Date:   Tue, 13 Apr 2021 13:52:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     faisal.latif@intel.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] i40iw: add pble resource files
Message-ID: <YHV4CFXzqTm23AOZ@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130075
X-Proofpoint-ORIG-GUID: x50ZgT_sAclp5bh10IpmZqsHMg_exSV5
X-Proofpoint-GUID: x50ZgT_sAclp5bh10IpmZqsHMg_exSV5
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=936 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130074
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Faisal Latif,

The patch 9715830157be: "i40iw: add pble resource files" from Jan 20,
2016, leads to the following static checker warning:

	drivers/infiniband/hw/i40iw/i40iw_pble.c:414 add_pble_pool()
	warn: '&chunk->list' not removed from list

drivers/infiniband/hw/i40iw/i40iw_pble.c
   391          }
   392          pble_rsrc->next_fpm_addr += chunk->size;
   393          i40iw_debug(dev, I40IW_DEBUG_PBLE, "next_fpm_addr = %llx chunk_size[%u] = 0x%x\n",
   394                      pble_rsrc->next_fpm_addr, chunk->size, chunk->size);
   395          pble_rsrc->unallocated_pble -= (chunk->size >> 3);
   396          list_add(&chunk->list, &pble_rsrc->pinfo.clist);
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
"chunk" is added to the list.

   397          sd_reg_val = (sd_entry_type == I40IW_SD_TYPE_PAGED) ?
   398                          sd_entry->u.pd_table.pd_page_addr.pa : sd_entry->u.bp.addr.pa;
   399          if (sd_entry->valid)
   400                  return 0;
   401          if (dev->is_pf) {
   402                  ret_code = i40iw_hmc_sd_one(dev, hmc_info->hmc_fn_id,
   403                                              sd_reg_val, idx->sd_idx,
   404                                              sd_entry->entry_type, true);
   405                  if (ret_code) {
   406                          i40iw_pr_err("cqp cmd failed for sd (pbles)\n");
   407                          goto error;
                                ^^^^^^^^^^
We hit an error

   408                  }
   409          }
   410  
   411          sd_entry->valid = true;
   412          return 0;
   413   error:
   414          kfree(chunk);
                ^^^^^^^^^^^^
"chunk" is freed but it's still on the list

   415          return ret_code;
   416  }

regards,
dan carpenter

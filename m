Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E913296031
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Oct 2020 15:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502454AbgJVNk0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Oct 2020 09:40:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45670 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437595AbgJVNk0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Oct 2020 09:40:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09MDdIvi151385;
        Thu, 22 Oct 2020 13:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=oFCHx9zFeFavK2m+PPqfOQmQlkdfIkCLeegEFWqCaRM=;
 b=wGNMW3/QBIzOi6ftyTqa+i1sv6uVoQ8n+l1T/uT9yoQbvMSCH97TYxqFWtihyoZtcajs
 vruZsi76KYW6LhjxuZ1oVh2ldBDXCBQrUpvViaWk9jdzT4g/MiOwP6TBvL+e+0oLpoTX
 KGCKg+PZYI7RfFyx7LSGRmauAsz0ej1PtsmJeo47SNsIatWnfNvhEXl1F45pnv24FpBW
 FJlbprCZZ5jtx1ZkXFthjl28fFJcgkhoid1zQAryo+uLzIjfCwgWpvV+edmXaN9DVOIv
 TLeL9ypYASyDNnFE3pOi3nr1Y3Vo39Zxy8EaGdIb/0ZcPVCyrRrVZI5MM/oJF7icBwRc VQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 347p4b61jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Oct 2020 13:40:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09MDVhMX194114;
        Thu, 22 Oct 2020 13:38:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 348ah0uhqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 13:38:22 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09MDcLba032208;
        Thu, 22 Oct 2020 13:38:21 GMT
Received: from mwanda (/10.175.217.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Oct 2020 06:38:21 -0700
Date:   Thu, 22 Oct 2020 16:38:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     avihaih@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/uverbs: Expose the new GID query API to user space
Message-ID: <20201022133816.GA2895864@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=3 bulkscore=0 mlxlogscore=879
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=901 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220093
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Avihai Horon,

The patch 9f85cbe50aa0: "RDMA/uverbs: Expose the new GID query API to
user space" from Sep 23, 2020, leads to the following static checker
warning:

	drivers/infiniband/core/uverbs_std_types_device.c:338 ib_uverbs_handler_UVERBS_METHOD_QUERY_GID_TABLE()
	warn: 'max_entries' unsigned <= 0

drivers/infiniband/core/uverbs_std_types_device.c
   312  static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_TABLE)(
   313          struct uverbs_attr_bundle *attrs)
   314  {
   315          struct ib_uverbs_gid_entry *entries;
   316          struct ib_ucontext *ucontext;
   317          struct ib_device *ib_dev;
   318          size_t user_entry_size;
   319          ssize_t num_entries;
   320          size_t max_entries;
   321          size_t num_bytes;
   322          u32 flags;
   323          int ret;
   324  
   325          ret = uverbs_get_flags32(&flags, attrs,
   326                                   UVERBS_ATTR_QUERY_GID_TABLE_FLAGS, 0);
   327          if (ret)
   328                  return ret;
   329  
   330          ret = uverbs_get_const(&user_entry_size, attrs,
   331                                 UVERBS_ATTR_QUERY_GID_TABLE_ENTRY_SIZE);
   332          if (ret)
   333                  return ret;
   334  
   335          max_entries = uverbs_attr_ptr_get_array_size(
   336                  attrs, UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES,
   337                  user_entry_size);
   338          if (max_entries <= 0)
                    ^^^^^^^^^^^^^^^^
size_t is unsigned so negative returns from uverbs_attr_ptr_get_array_size()
are treated as high postives.

   339                  return -EINVAL;
   340  
   341          ucontext = ib_uverbs_get_ucontext(attrs);
   342          if (IS_ERR(ucontext))
   343                  return PTR_ERR(ucontext);
   344          ib_dev = ucontext->device;
   345  
   346          if (check_mul_overflow(max_entries, sizeof(*entries), &num_bytes))
   347                  return -EINVAL;
   348  
   349          entries = uverbs_zalloc(attrs, num_bytes);
   350          if (!entries)
   351                  return -ENOMEM;
   352  

regards,
dan carpenter

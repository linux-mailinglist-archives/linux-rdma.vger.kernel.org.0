Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0E82F905
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 11:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfE3JKb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 05:10:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60176 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfE3JKb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 05:10:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U98lrF118137;
        Thu, 30 May 2019 09:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=Orv4tLiGNbqEhNbMz4TtVn+8rD3Srsrjvl3qYYhMZq8=;
 b=YiH2t8u3u6jf9iMMqk/fDs7JjC0Mk/EMUZT3DGDYHg7NiPkbz3iSTNkSe2GdiWs7RFyM
 /Tdq0dW6x8UB2OkZLs/Zfb0OzVaxCbrN5GH/pL717swisLnhWtMsWm0I9mZZ9uIL2epk
 Xg4ViQwXnpp97dfQLip+nCViDoVCfuNWltlCiStg64/PisHcaXa1EJdvNqV6fD9CU/5M
 dzrSxMOfD8DYI37x8LH3tq8hRXExnRF4OVno9g7tPXUEY/drGQxPqTH3SOCv8X48Q4BE
 NKjKN4mk6ncZ/r/KvaZabTLPX+N4angpI/NuRwIf9TeAVAIXUof2Wkeg8Hteog5GqCpP BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2spu7dq4a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 09:10:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U9ARqr126745;
        Thu, 30 May 2019 09:10:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2sqh7470wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 09:10:28 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4U9ARk8021600;
        Thu, 30 May 2019 09:10:27 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 02:10:26 -0700
Date:   Thu, 30 May 2019 12:10:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     mitko.haralanov@intel.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] IB/hfi1: Rework fault injection machinery
Message-ID: <20190530091021.GA26681@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=492
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=522 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300070
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Mitko Haralanov,

The patch a74d5307caba: "IB/hfi1: Rework fault injection machinery"
from May 2, 2018, leads to the following static checker warning:

	drivers/infiniband/hw/hfi1/fault.c:183 fault_opcodes_write()
	error: passing untrusted data 'i' to 'clear_bit()'

drivers/infiniband/hw/hfi1/fault.c
   144          if (copy_from_user(data, buf, copy))
   145                  return -EFAULT;
   146  
   147          ret = debugfs_file_get(file->f_path.dentry);
   148          if (unlikely(ret))
   149                  return ret;
   150          ptr = data;
   151          token = ptr;
   152          for (ptr = data; *ptr; ptr = end + 1, token = ptr) {
   153                  char *dash;
   154                  unsigned long range_start, range_end, i;
   155                  bool remove = false;
   156  
   157                  end = strchr(ptr, ',');
   158                  if (end)
   159                          *end = '\0';
   160                  if (token[0] == '-') {
   161                          remove = true;
   162                          token++;
   163                  }
   164                  dash = strchr(token, '-');
   165                  if (dash)
   166                          *dash = '\0';
   167                  if (kstrtoul(token, 0, &range_start))
                                               ^^^^^^^^^^^^
Smatch marks this as untrusted

   168                          break;
   169                  if (dash) {
   170                          token = dash + 1;
   171                          if (kstrtoul(token, 0, &range_end))
                                                       ^^^^^^^^^^
and this also

   172                                  break;
   173                  } else {
   174                          range_end = range_start;
   175                  }
   176                  if (range_start == range_end && range_start == -1UL) {
   177                          bitmap_zero(fault->opcodes, sizeof(fault->opcodes) *
   178                                      BITS_PER_BYTE);
   179                          break;
   180                  }
   181                  for (i = range_start; i <= range_end; i++) {
   182                          if (remove)
   183                                  clear_bit(i, fault->opcodes);
                                                  ^
   184                          else
   185                                  set_bit(i, fault->opcodes);
                                                ^

Smatch complains that "i" can be beyond the end of bitmap.

   186                  }
   187                  if (!end)
   188                          break;

regards,
dan carpenter

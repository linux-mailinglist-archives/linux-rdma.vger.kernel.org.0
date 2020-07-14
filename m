Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D0B21ED8B
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 12:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGNKC6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 06:02:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37392 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgGNKC5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 06:02:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EA2sPJ172771;
        Tue, 14 Jul 2020 10:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=4mYmn1l/yj85RidUm9ymNcpIijGi2NYXt4YolYKFXfo=;
 b=lwwz+i9MKL6BnBvgcY192Ov/cAzav0mjSwwZQCte5O5+RQHCpXAB1b3oj6fqliI2X08c
 vJLhMF9yJsx0rAbpiiTDk9UX+rcml6YcFcUTnCEaFRoDmNZMt04CI4jcVuKKBpDgm8gv
 hDe3qn6UoL+0+qBxR0dDY4gfCIr8c5KzdmCxRhxi6u04/WM0d1Wl5WTWEC2i88l8CLCc
 cjvSzSHwP7Oj9QVAAYH27N/g8gQoWFqnP/WjxUY0Ryq87nJq80kxv3ttJ0M87tKgOYPg
 MpCQ+LLx7WW9T49hoC4ksj7cKXkgI5qAJvRjhWcwv4BaoTCZFURtHMQNDcetZ8rP6kBe Wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32762ncbd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jul 2020 10:02:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06E9verV065481;
        Tue, 14 Jul 2020 10:00:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 327q6ryfnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 10:00:51 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06EA0oTm025570;
        Tue, 14 Jul 2020 10:00:50 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Jul 2020 03:00:50 -0700
Date:   Tue, 14 Jul 2020 13:00:44 +0300
From:   <dan.carpenter@oracle.com>
To:     paulb@mellanox.com
Cc:     Paul Blakey <paulb@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5e: CT: Save ct entries tuples in hashtables
Message-ID: <20200714100044.GA280741@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=3
 phishscore=0 malwarescore=0 mlxlogscore=977 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=967 lowpriorityscore=0
 bulkscore=0 suspectscore=3 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140076
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Paul Blakey,

The patch bc562be9674b: "net/mlx5e: CT: Save ct entries tuples in
hashtables" from Mar 29, 2020, leads to the following static checker
warning:

	drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c:246 mlx5_tc_ct_rule_to_tuple_nat()
	error: buffer overflow 'tuple->ip.src_v6.in6_u.u6_addr32' 4 <= 7

drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
   229  
   230                  offset = act->mangle.offset;
   231                  val = act->mangle.val;
   232                  switch (act->mangle.htype) {
   233                  case FLOW_ACT_MANGLE_HDR_TYPE_IP4:
   234                          if (offset == offsetof(struct iphdr, saddr))
   235                                  tuple->ip.src_v4 = cpu_to_be32(val);
   236                          else if (offset == offsetof(struct iphdr, daddr))
   237                                  tuple->ip.dst_v4 = cpu_to_be32(val);
   238                          else
   239                                  return -EOPNOTSUPP;
   240                          break;
   241  
   242                  case FLOW_ACT_MANGLE_HDR_TYPE_IP6:
   243                          ip6_offset = (offset - offsetof(struct ipv6hdr, saddr));
   244                          ip6_offset /= 4;
   245                          if (ip6_offset < 8)
                                    ^^^^^^^^^^^^^^

   246                                  tuple->ip.src_v6.s6_addr32[ip6_offset] = cpu_to_be32(val);
                                                         ^^^^^^^^^^^^^^^^^^^^^
This is a 4 element array.

   247                          else
   248                                  return -EOPNOTSUPP;
   249                          break;
   250  
   251                  case FLOW_ACT_MANGLE_HDR_TYPE_TCP:
   252                          if (offset == offsetof(struct tcphdr, source))
   253                                  tuple->port.src = cpu_to_be16(val);
   254                          else if (offset == offsetof(struct tcphdr, dest))
   255                                  tuple->port.dst = cpu_to_be16(val);
   256                          else
   257                                  return -EOPNOTSUPP;
   258                          break;

regards,
dan carpenter

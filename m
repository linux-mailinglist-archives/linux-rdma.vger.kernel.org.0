Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FC11D95CC
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 14:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgESMCV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 08:02:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34450 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgESMCU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 08:02:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JBvCut112596;
        Tue, 19 May 2020 12:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=TV4pyYsWRPe8RNrW0FmUhh/p3vgEJPRT8frZ7NnfWNM=;
 b=YwfQmGjeOV25s5LvcFUOYSEYWMAeG0dPM0CjAauHWFnzeqFZJ84zL+l5j2Tje26y3NCO
 dKrtO/Jhais/Fik9Yd9wPgwLEHs9qzHVWGQ7a4i3/92qq5S8fA+TjMhQTSK0A/etat7q
 0lG47/dGq7UKDvU9Kg6bwK4nw0ViTOo9Vpuz3zUEDODKP5hGgoxAbOWl2xM0y8BCR/8O
 X7RTe+M/Wu4uarN6D7+mFO+p2wCgzz/4OxNc52QSkpz2Hf1Y75KRPI2LD40olDu/nbFU
 NnmjX/xTu+I2/NjFvITkDPuUBKEZ6xMQ+yLwzztAITRi5wkc2G94ny3kfiuL9I1K4Ml4 Ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3127kr4x0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 12:02:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JBqYlZ042693;
        Tue, 19 May 2020 12:02:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 313gj1j69h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 12:02:16 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04JC2FRN025043;
        Tue, 19 May 2020 12:02:15 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 May 2020 05:02:14 -0700
Date:   Tue, 19 May 2020 15:02:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     jinpu.wang@cloud.ionos.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/rtrs: server: main functionality
Message-ID: <20200519120209.GA42765@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=3 mlxlogscore=989
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005190108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=3 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190108
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Jack Wang,

The patch 9cb837480424: "RDMA/rtrs: server: main functionality" from
May 11, 2020, leads to the following static checker warning:

	drivers/infiniband/ulp/rtrs/rtrs-srv.c:1224 rtrs_srv_rdma_done()
	warn: array off by one? 'sess->mrs[msg_id]'

drivers/infiniband/ulp/rtrs/rtrs-srv.c
  1207                  }
  1208                  rtrs_from_imm(be32_to_cpu(wc->ex.imm_data),
  1209                                 &imm_type, &imm_payload);
  1210                  if (likely(imm_type == RTRS_IO_REQ_IMM)) {
  1211                          u32 msg_id, off;
  1212                          void *data;
  1213  
  1214                          msg_id = imm_payload >> sess->mem_bits;
  1215                          off = imm_payload & ((1 << sess->mem_bits) - 1);
  1216                          if (unlikely(msg_id > srv->queue_depth ||
                                                    ^
This should definitely be >=

  1217                                       off > max_chunk_size)) {
                                                 ^
My only question is should "off" be >=.  I feel like probably it should
but I'm not sure.

  1218                                  rtrs_err(s, "Wrong msg_id %u, off %u\n",
  1219                                            msg_id, off);
  1220                                  close_sess(sess);
  1221                                  return;
  1222                          }
  1223                          if (always_invalidate) {
  1224                                  struct rtrs_srv_mr *mr = &sess->mrs[msg_id];
                                                                 ^^^^^^^^^^^^^^^^^^
  1225  
  1226                                  mr->msg_off = off;
  1227                                  mr->msg_id = msg_id;
  1228                                  err = rtrs_srv_inv_rkey(con, mr);
  1229                                  if (unlikely(err)) {
  1230                                          rtrs_err(s, "rtrs_post_recv(), err: %d\n",
  1231                                                    err);
  1232                                          close_sess(sess);
  1233                                          break;
  1234                                  }
  1235                          } else {
  1236                                  data = page_address(srv->chunks[msg_id]) + off;
  1237                                  process_io_req(con, data, msg_id, off);
  1238                          }
  1239                  } else if (imm_type == RTRS_HB_MSG_IMM) {
  1240                          WARN_ON(con->c.cid);
  1241                          rtrs_send_hb_ack(&sess->s);
  1242                  } else if (imm_type == RTRS_HB_ACK_IMM) {

regards,
dan carpenter

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D934A3667A1
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 11:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbhDUJIg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 05:08:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58134 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbhDUJIg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Apr 2021 05:08:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13L8wxcX022193;
        Wed, 21 Apr 2021 09:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=kA499dwh92kX9fByiz/pSVEUq/jdnxUmU89K5ZoGaC4=;
 b=CYvIJOHAXIdP90Na6DtBi9KlBQxAHgY8GWp5x7697hj+UwME88AAinhwtaWad32p/5Q6
 WhTHsYH1o51V8Clyl5q3z/bGz4zqP/bO9y/T2eRMjV4xv/cY44JG9ZCovu/UADmJZ3nf
 tpNSbBspv4ljIiCYMC3r5UxlhcyOZ42k90kD/MmQt6QYaKThRsw9xyeqJ/+bTGsjJVaa
 gpvr/Bu2/kfZsRP2QW9WVeKpL872PpZsku6/qzsmmdnHaYdRnVBlzVYH25hbGxGLuESv
 iCYFn1u3FEGM2FjkNz1Bz6SzAQDaRZWk4E4nRngL3FY6SLGPoWIWPKEo2xY1opcY2fLq JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37yqmnhnrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 09:08:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13L94wM1026022;
        Wed, 21 Apr 2021 09:08:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38098rf77s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 09:08:00 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13L97xoJ036471;
        Wed, 21 Apr 2021 09:08:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 38098rf77h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 09:07:59 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13L97xPl018834;
        Wed, 21 Apr 2021 09:07:59 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Apr 2021 09:07:58 +0000
Date:   Wed, 21 Apr 2021 12:07:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     gi-oh.kim@cloud.ionos.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] block/rnbd-clt: Support polling mode for IO latency
 optimization
Message-ID: <YH/rabHwkA8UgzH1@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: oX4NCWFNJj2cR1mm1AhlYmmMLAh6vijM
X-Proofpoint-GUID: oX4NCWFNJj2cR1mm1AhlYmmMLAh6vijM
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9960 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210071
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Gioh Kim,

The patch fa607fcb87f6: "block/rnbd-clt: Support polling mode for IO
latency optimization" from Apr 19, 2021, leads to the following
static checker warning:

	drivers/infiniband/ulp/rtrs/rtrs-clt.c:2998 rtrs_clt_rdma_cq_direct()
	error: uninitialized symbol 'cnt'.

drivers/infiniband/ulp/rtrs/rtrs-clt.c
  2977  int rtrs_clt_rdma_cq_direct(struct rtrs_clt *clt, unsigned int index)
  2978  {
  2979          int cnt;

What about if no sessions are connected?

  2980          struct rtrs_con *con;
  2981          struct rtrs_clt_sess *sess;
  2982          struct path_it it;
  2983  
  2984          rcu_read_lock();
  2985          for (path_it_init(&it, clt);
  2986               (sess = it.next_path(&it)) && it.i < it.clt->paths_num; it.i++) {
  2987                  if (READ_ONCE(sess->state) != RTRS_CLT_CONNECTED)
  2988                          continue;
  2989  
  2990                  con = sess->s.con[index + 1];
  2991                  cnt = ib_process_cq_direct(con->cq, -1);
  2992                  if (cnt)
  2993                          break;

I don't know any of this code but I would have expect use to add up
cnt for the whole loop...  Something like:

			ret = ib_process_cq_direct(con->cq, -1);
			if (ret < 0)
				break;
			cnt += ret;

  2994          }
  2995          path_it_deinit(&it);
  2996          rcu_read_unlock();
  2997  
  2998          return cnt;

		if (ret < 0)
			return ret;

		return cnt;

  2999  }

regards,
dan carpenter

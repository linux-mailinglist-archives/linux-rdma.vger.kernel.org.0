Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C40E48B4
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2019 12:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502510AbfJYKlW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Oct 2019 06:41:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45996 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502503AbfJYKlV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Oct 2019 06:41:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9PAd424000997;
        Fri, 25 Oct 2019 10:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=6U1uhVXVY7QsPnJK9+ZulDsRGC5bxfFeessMTgt2YR0=;
 b=jpnQ3DkjX9z7PidFqyxaU1qSjAiaO0PbVDv3MhK5kNlI0L5cAGiRMYZJ2CT7lVhvbJiq
 ypvOggOD7xNiRxTGyuDeCn90zHPHRkjLHDkuYzRIDcBjWp+BjqFPiHdMjPmeDoiUKxwj
 s7wn+U26qsEyEesBgM9albqys3QOSDpc7tWT8Nf5EmMftWmusczFq13/wdCS7HkMc8CJ
 lhsD9nHcSiigtZL25gPpqvXQ2Q6hoXFtdw6JYQknPadSak66fg57JL4nW2UlOhSDOPfK
 AoGAwC2HSGTzStWg2jSivrtBY11pRatnJqZ49uLjXTk3hygKxP3UyhXTytKzxz3Gr91P lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vqu4r9xer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 10:41:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9PAYOnH124893;
        Fri, 25 Oct 2019 10:41:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vu0frbcnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 10:41:18 +0000
Received: from abhmp0021.oracle.com (abhmp0021.oracle.com [141.146.116.27])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9PAfHAR016406;
        Fri, 25 Oct 2019 10:41:17 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Oct 2019 10:41:17 +0000
Date:   Fri, 25 Oct 2019 13:41:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     rajur@chelsio.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/iw_cxgb4: Avoid touch after free error in ARP
 failure handlers
Message-ID: <20191025104111.GA12120@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=693
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910250100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=772 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910250101
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Raju Rangoju,

The patch 1dad0ebeea1c: "RDMA/iw_cxgb4: Avoid touch after free error
in ARP failure handlers" from May 15, 2017, leads to the following
static checker warning:

	drivers/infiniband/hw/cxgb4/cm.c:4310 process_work()
	warn: 'skb' was already freed.

drivers/infiniband/hw/cxgb4/cm.c
  4289  static void process_work(struct work_struct *work)
  4290  {
  4291          struct sk_buff *skb = NULL;
  4292          struct c4iw_dev *dev;
  4293          struct cpl_act_establish *rpl;
  4294          unsigned int opcode;
  4295          int ret;
  4296  
  4297          process_timedout_eps();
  4298          while ((skb = skb_dequeue(&rxq))) {
  4299                  rpl = cplhdr(skb);
  4300                  dev = *((struct c4iw_dev **) (skb->cb + sizeof(void *)));
  4301                  opcode = rpl->ot.opcode;
  4302  
  4303                  if (opcode >= ARRAY_SIZE(work_handlers) ||
  4304                      !work_handlers[opcode]) {
  4305                          pr_err("No handler for opcode 0x%x.\n", opcode);
  4306                          kfree_skb(skb);
  4307                  } else {
  4308                          ret = work_handlers[opcode](dev, skb);
  4309                          if (!ret)
  4310                                  kfree_skb(skb);

I'm not sure why this warning didn't show up before... :(

We added some kfree_skb() calls to _put_ep_safe() and _put_pass_ep_safe().
The thing about kfree_skb() is that it's refcounted so it might not
free anything so this could be a false positive.  I've looked at the
code and it looks like it could be a bug?

  4311                  }
  4312                  process_timedout_eps();
  4313          }
  4314  }

regards,
dan carpenter

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8991B7989
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 17:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgDXP23 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 11:28:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40720 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgDXP22 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Apr 2020 11:28:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03OFIll1061933;
        Fri, 24 Apr 2020 15:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=zOaIIh5Y3Ixgy8+bW/8s0a5JA8RFQkLrn9lA9JvNLy8=;
 b=JKL8z3JICdqTHf3tVLjbYDCwsZ7/2LePqlPUskPF0EEb4j31YoDElbnDjxpFL7PFB3+T
 o7b41+JXFs9vXmWXCDT/vOm7xCk0q7RbtGAtfGax9OItLT9PlfXcx+kfzWfqacyU80+x
 PjHtLZxxYqEPZIHf/slDkzxRYAJh5iHOEMxkTs+HYM5sKfeCeD8eR3H0fr4NzMotyJR0
 YkVW9t6u8SyJ5F40u7pDgPfA9vX2A0x97gbk+zUOIqtnUqq7HrIfhF9/+Hp6VR3dAe1a
 Plcs7PwbgDs45i7rOIe5h0UMAyUldWQ3p/8GEQnmSyAyx74WehsytUu9dVkLeGfP8U+B XQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30ketdn08h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 15:28:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03OFBdxZ096279;
        Fri, 24 Apr 2020 15:28:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30k7qxbu2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 15:28:22 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03OFSLZW015782;
        Fri, 24 Apr 2020 15:28:21 GMT
Received: from dhcp-10-159-159-71.vpn.oracle.com (/10.159.159.71)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Apr 2020 08:28:21 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>
Subject: Request for feedback : Possible use-after-free in routing SA query
 via netlink
Message-ID: <8fbdf10e-3f08-6407-eb0d-a1bf663873c3@oracle.com>
Date:   Fri, 24 Apr 2020 08:28:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9601 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=11 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9601 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 suspectscore=11 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240121
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi All,

I wanted some feedback on a crash caused due to use-after-free in the 
ibacm code path [while routing SA query via netlink].

Commit 3ebd2fd IB/sa: Put netlink request into the request list before sending

Above commit moved adding the query to the request list before ib_nl_snd_msg
and moved ib_nl_snd_msg out of the spinlock (request_lock).

However, if there is a delay in sending out the request (For
eg: Delay due to low memory situation) the timer to handle request timeout
might kick in before the request is sent out to ibacm via netlink.
ib_nl_request_timeout may result in release of the query (by call to send_handler) 
while ib_nl_snd_msg is still accessing query.


We get the following stacktrace for the crash -

[<ffffffffa02f43cb>] ? ib_pack+0x17b/0x240 [ib_core]
[<ffffffffa032aef1>] ib_sa_path_rec_get+0x181/0x200 [ib_sa]
[<ffffffffa0379db0>] rdma_resolve_route+0x3c0/0x8d0 [rdma_cm]
[<ffffffffa0374450>] ? cma_bind_port+0xa0/0xa0 [rdma_cm]
[<ffffffffa040f850>] ? rds_rdma_cm_event_handler_cmn+0x850/0x850
[rds_rdma]
[<ffffffffa040f22c>] rds_rdma_cm_event_handler_cmn+0x22c/0x850
[rds_rdma]
[<ffffffffa040f860>] rds_rdma_cm_event_handler+0x10/0x20 [rds_rdma]
[<ffffffffa037778e>] addr_handler+0x9e/0x140 [rdma_cm]
[<ffffffffa026cdb4>] process_req+0x134/0x190 [ib_addr]
[<ffffffff810a02f9>] process_one_work+0x169/0x4a0
[<ffffffff810a0b2b>] worker_thread+0x5b/0x560
[<ffffffff810a0ad0>] ? flush_delayed_work+0x50/0x50
[<ffffffff810a68fb>] kthread+0xcb/0xf0
[<ffffffff816ec49a>] ? __schedule+0x24a/0x810
[<ffffffff816ec49a>] ? __schedule+0x24a/0x810
[<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
[<ffffffff816f25a7>] ret_from_fork+0x47/0x90
[<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
....
RIP  [<ffffffffa03296cd>] send_mad+0x33d/0x5d0 [ib_sa] 

On analysis of the vmcore, we see crash happens at -

ib_sa_path_rec_get
  send_mad
     ib_nl_make_request()
        ib_nl_send_msg
                1  static void ib_nl_set_path_rec_attrs(struct sk_buff *skb,
                2        struct ib_sa_query *query)
                3  {
                4   struct ib_sa_path_rec *sa_rec = query->mad_buf->context[1];
                5   struct ib_sa_mad *mad = query->mad_buf->mad;
                6   ib_sa_comp_mask comp_mask = mad->sa_hdr.comp_mask;

Page fault occurs at line 5 while trying to access query->mad_buf->mad;

If we look at the query, it does not appear to be a valid ib_sa_query. Instead
looks like a pid struct for a process -> Use-after-free situation.

We could simulate the crash by explicitly introducing a delay in ib_nl_snd_msg with
a sleep. The timer kicks in before ib_nl_send_msg has even sent out the request 
and releases the query. We could reproduce the crash with a similar stack trace.

To summarize - We have a use-after-free possibility here when the timer(ib_nl_request_timeout)
kicks in before ib_nl_snd_msg has completed sending the query out to ibacm via netlink. The 
timeout handler ie ib_nl_request_timeout may result in releasing the query while ib_nl_snd_msg 
is still accessing query.

Appreciate your thoughts on the above issue.


Thanks,
Divya 


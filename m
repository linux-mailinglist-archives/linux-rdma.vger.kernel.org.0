Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC48F250768
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 20:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHXSYp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 14:24:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47738 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHXSYp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 14:24:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OIEddG142642;
        Mon, 24 Aug 2020 18:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=GWl0xEwecc8iDt9Tb4KcWaJ605wliyFH5gkIPi6sbBU=;
 b=qsDEqTmEFTydQq+9CR7ebzNTtRqKq8OyPbcpWEBoMNr9UhhctvRZuCUmA1zhOQI9kWSq
 WY3n/pA8DcedYRSbQxVsAzCubLghFti3RKVPVkHx4HxXpjbzZdlyEdDA8kwrdKMjPlD4
 5Vv4Hf3dEzxzN4BFli5jvg9KDfajL7DUWLm6a85okrQpB1CMno5h1fk5TFNFa2k3+2w6
 kgnZpDm0kIzASFnsNRWY8UAxKREHW2nzOlGFcN2oxrdeh5GSCvOFPf3fOvXr7sQ4mo0T
 TDAbEE0thVoI4FATQbiWPwW+H2B6vjDSiG5E1mE8chUZvHgjWdWb/TSSIymrnbnYfiI/ 0g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 333cshx88k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 18:24:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OIEims040499;
        Mon, 24 Aug 2020 18:24:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 333r9j0y8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 18:24:41 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07OIOevA013843;
        Mon, 24 Aug 2020 18:24:41 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Aug 2020 11:24:40 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v3 0/3] IB CM tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200824174213.GA3256703@nvidia.com>
Date:   Mon, 24 Aug 2020 14:24:40 -0400
Cc:     linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C1EC1AC-8385-4E08-9C4A-97B04AF3763B@oracle.com>
References: <159767229823.2968.6482101365744305238.stgit@klimt.1015granger.net>
 <20200824174213.GA3256703@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008240149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240149
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Aug 24, 2020, at 1:42 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Mon, Aug 17, 2020 at 09:53:05AM -0400, Chuck Lever wrote:
>> Oracle has an interest in a common observability infrastructure in
>> the RDMA core and ULPs. Introduce static tracepoints that can also
>> be used as hooks for eBPF scripts, replacing infrastructure that
>> is based on printk. This takes the same approach as tracepoints
>> added recently in the RDMA CM.
>>=20
>> Change since v2:
>> * Rebase on v5.9-rc1
>>=20
>> Changes since RFC:
>> * Correct spelling of example tracepoint in patch description
>> * Newer tool chains don't care for tracepoints with the same name
>> in different subsystems
>> * Display ib_cm_events, not ib_events
>=20
> Doesn't compile:
>=20
> In file included from drivers/infiniband/core/cm_trace.h:414,
>                 from drivers/infiniband/core/cm_trace.c:15:
> ./include/trace/define_trace.h:95:42: fatal error: ./cm_trace.h: No =
such file or directory
>   95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>      |                                          ^
> compilation terminated.

I am not able to reproduce this failure.

gcc (GCC) 10.1.1 20200507 (Red Hat 10.1.1-1)

What if you edit drivers/infiniband/core/cm_trace.h and
change the definition of TRACE_INCLUDE_PATH from "." to
"../../drivers/infiniband/core" ?


--
Chuck Lever




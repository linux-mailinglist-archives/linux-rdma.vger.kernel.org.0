Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3007B2506C2
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 19:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHXRn7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 13:43:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43252 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgHXRn6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 13:43:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OHcZuX074323;
        Mon, 24 Aug 2020 17:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=WiZ68Ff1iNg8kvhunH3MlDTy2ke+NWWxyDEZZcB18Pw=;
 b=kZQaUMHtZFP8y/2o5qBInCjn+bo7Cm7QY1urJzNyrnkZilNbFF2mzbK6hbDc4UbFFcv+
 LHaY613xLnMreAgszMyW5HWDkMv5mwsdndIGe5Ahb+f2pP5dWvjkXXN1Zot7m1YZimTb
 gn6IPiBf9TNescNUFUlqlB68dfscXRXPAbDQUFghjeVloCeKL1WocxeE+1fD/x5UoT2W
 zEWFhS1hXo66od9CTE2c7V3QvJY0wuqdr/oimPYvAW7Jtq0SjJ4RxQjA+4RVs+VZ4tVJ
 0n6xv9S5EV+1ryPSSO+ALJVs/Sl4eIfpKZOeuhZo9Ox8NElLllM0b4x9Eg9k2j83fnsw QQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 333cshx1ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 17:43:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OHeZBs147478;
        Mon, 24 Aug 2020 17:43:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 333rtwtru0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 17:43:56 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07OHhtiI010563;
        Mon, 24 Aug 2020 17:43:55 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Aug 2020 10:43:55 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v3 0/3] IB CM tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200824174213.GA3256703@nvidia.com>
Date:   Mon, 24 Aug 2020 13:43:54 -0400
Cc:     linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <84901C6D-8144-4643-9B2B-B597F9A7FB8D@oracle.com>
References: <159767229823.2968.6482101365744305238.stgit@klimt.1015granger.net>
 <20200824174213.GA3256703@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240144
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

I've been using these patches for several weeks, so WFM.
I'll have a look.


--
Chuck Lever




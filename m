Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D2C132918
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 15:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgAGOjh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 09:39:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35158 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGOjh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 09:39:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007EcoJb180518;
        Tue, 7 Jan 2020 14:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=hzFj8g2wU2aglMqbHfta/EN8tzqfVIk7GkFxTl22Oqk=;
 b=B8vxLiLr3e4Djg4nX1qLXfKqIdmvaNM0Q0pyGz0a7U7DulH4oXOcdue0CFVG7jb4xQI+
 KZ7sQ3RUVumCXxgxEyNLGNrvZfu85vwoODVfbSdSZr8CPj0isxN3tkiDBoGgGFmWQjSZ
 Eey6Eu4T/OC9DaeCz9ofv+LBoM9k94152XZEF2wOKyeuXqlP4spAG9cZT21vE/3hjBM2
 WWa3OVEO0R7Z48FLR6MeOE1bl0tmoS3wtGKfLbTAb0qOUyBs/+nBs+MveZF/aK4iF2dA
 r9Eu+N+J8rA5VC7KIZ8/G5kmeYwDdirqOOxTf2620xpjdtT7OmGKOLTTvwb26XD84AWt ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xakbqnsjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 14:39:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007EcSL8165989;
        Tue, 7 Jan 2020 14:39:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xcpcqd1k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 14:39:11 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 007Ed8Af021883;
        Tue, 7 Jan 2020 14:39:08 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 06:39:08 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v9 0/3] Proposed trace points for RDMA/core
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200107134728.GA375@infradead.org>
Date:   Tue, 7 Jan 2020 09:39:05 -0500
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <F6E6C508-FB7F-4E57-AEBC-C1B0E15A6722@oracle.com>
References: <20191216154924.21101.64860.stgit@manet.1015granger.net>
 <20191218002214.GL16762@mellanox.com> <20191218053644.GJ66555@unreal>
 <FFC65516-E488-472C-90EA-DBE54BE341C8@oracle.com>
 <20200107134728.GA375@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070121
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jan 7, 2020, at 8:47 AM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Wed, Dec 18, 2019 at 08:20:20AM -0500, Chuck Lever wrote:
>> 
>> 
>>> On Dec 18, 2019, at 12:36 AM, Leon Romanovsky <leon@kernel.org> wrote:
>>> 
>>> On Wed, Dec 18, 2019 at 12:22:19AM +0000, Jason Gunthorpe wrote:
>>>> On Mon, Dec 16, 2019 at 10:53:43AM -0500, Chuck Lever wrote:
>>>>> Hey y'all-
>>>>> 
>>>>> Refresh of the RDMA/core trace point patches. Anything else needed
>>>>> before these are acceptable?
>>>> 
>>>> Can Leon compile and run it yet?
>>> 
>>> Nope, it is enough to apply first patch to see compilation error.
>> 
>> I've never seen that here. There is another report of this problem
>> with an earlier version of the series, so I thought it had been
>> resolved.
>> 
>> I'll look into it.
> 
> You tend to need a line like:
> 
> ccflags-y += -I $(srctree)/$(src)               # needed for trace events

Thanks, that was exactly the one-line fix applied in v10 of this series.


> to ensure the trace header actually gets included for out of source
> tree builds.  Or move the trace header to include/trave/events/.  I find
> that annoying for simple modules, but for a subsystem where the trace
> header might be spread over various directories that might end up being
> much easier.

--
Chuck Lever




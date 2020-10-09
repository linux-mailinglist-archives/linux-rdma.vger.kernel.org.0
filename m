Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5060C288182
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 06:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgJIEuL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 00:50:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51980 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgJIEtn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 00:49:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0994nfYL137388;
        Fri, 9 Oct 2020 04:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7/RLNjsuC3qsrA4s66wvsnufPtcpvd7oKG7pS23Rj+8=;
 b=zdkDFXC/ltfZZOWY7NtzeZgYlDLSywR07hnkiVI7vT9o6TKnDaLQE8HSMn9kneFlZOmJ
 CQHKJz+elBNERswaWdrqIuSiebwsEQWey0kCHJS9S2gAkwI2e92FiM6fLMX0QkeBKh/p
 LFfczuEaBoGLKk3pGlPR5eJaIbjHy/WfWXREMWF+M7OjShQOsdXWSHU85x8JkWzJNUbV
 +3Mf6jRNLuEVEE6xsj0oR41guSjpgP8AgcthqNYWcpYSOAKVBSVzq+JCJb16VFX+MsZ4
 G+5zbMxFts/V8DpdC1SfI6b1dKClJUG8YxQFZijs8WNVkzxRmQFXqiF1oT55yVMrYPoJ 1g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3429jmhcrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 09 Oct 2020 04:49:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0994kGSa029341;
        Fri, 9 Oct 2020 04:49:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3429k0mdpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Oct 2020 04:49:40 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0994ncMD029088;
        Fri, 9 Oct 2020 04:49:39 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Oct 2020 21:49:38 -0700
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
References: <20201005142554.GS9916@ziepe.ca>
 <3e9497cb-1ccd-2bc0-bbca-41232ebd6167@oracle.com>
 <20201005154548.GT9916@ziepe.ca>
 <765ff6f8-1cba-0f12-937b-c8893e1466e7@oracle.com>
 <20201006124627.GH5177@ziepe.ca>
 <ad892ef5-9b86-2e75-b0f8-432d8e157f60@oracle.com>
 <20201007111636.GD3678159@unreal>
 <4d29915c-3ed7-0253-211b-1b97f5f8cfdf@oracle.com>
 <20201008103641.GM13580@unreal>
 <aec6906d-7be5-b489-c7dc-0254c4538723@oracle.com>
 <20201008160814.GF5177@ziepe.ca>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <727de097-4338-c1d8-73a0-1fce0854f8af@oracle.com>
Date:   Fri, 9 Oct 2020 12:49:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201008160814.GF5177@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090034
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090035
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/9/20 12:08 AM, Jason Gunthorpe wrote:
> On Thu, Oct 08, 2020 at 07:08:42PM +0800, Ka-Cheong Poon wrote:
>> Note that namespace does not really play a role in this "rogue" reasoning.
>> The init_net is also a namespace.  The "rogue" reasoning means that no
>> kernel module should start a listening RDMA endpoint by itself with or
>> without any extra namespaces.  In fact, to conform to this reasoning, the
>> "right" thing to do would be to change the code already in upstream to get
>> rid of the listening RDMA endpoint in init_net!
> 
> Actually I think they all already need user co-ordination?
>   
> - NFS, user has to setup and load exports
> - Storage Targets, user has to setup the target
> - IPoIB, user has to set the link up
> 
> etc.
> 
> Each of those could provide the anchor to learn the namespace.


It is unclear how this is related to the question at hand.  It
is not about learning the namespace.  A kernel module knows
when a namespace is created.  There is no need to learn it.  The
question is creating a kernel RDMA endpoint in a namespace without
adding a reference to that namespace.  The analogy to the daemon
scenario is that a daemon starts a socket endpoint at start up.
No one calls that endpoint "rogue".  Why is that a kernel module
should not start a socket endpoint at start up?  Why is that socket
endpoint "rogue"?  The reason is still not being given.

As I mentioned before, this is a very serious restriction on how
the RDMA subsystem can be used in a namespace environment by kernel
module.  The reason given for this restriction is that any kernel
socket without a corresponding user space file descriptor is "rogue".
All Internet protocol code create a kernel socket without user
interaction.  Are they all "rogue"?



-- 
K. Poon
ka-cheong.poon@oracle.com



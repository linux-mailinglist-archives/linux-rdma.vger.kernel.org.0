Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090EC290CDD
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 22:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392726AbgJPUtr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 16:49:47 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60564 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391060AbgJPUtr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 16:49:47 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09GKn6bs040407;
        Fri, 16 Oct 2020 20:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=DFgnVIfarW6F3Y3YjwRMQU65TdFoWaDPYBkL8LdviC8=;
 b=kGhghMThp7temKJqbipB8egZFl3NUgSmR9exFieqcUvbEE5vPRdZ1n6nPd2zgprDmo28
 U8LX45CstpMi2bjr/OUKnsSZkDKMfysl5se4tai3kJWLAbiXWCKMOPa6zN+EDyx8ryUq
 d0r7amjaxG1HIR2Tl0bvlcNjpao9G2qb3l9ttwNkCTA4Jakddt/Fpc4E2ObFuUDy1nEQ
 gkafBGK52IWABe6QzHp3tpCrLBVN13hSlTybRAjVNLBUeFObbPFADJugt2VoK8i5AdQ2
 tp5Eq35VdTj3mDWKrhNtyi7amWtomGIQsGhbU2i1cjgMDYkSPhEglPCaAqgC2mmfOt8a 3w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 346g8grvu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Oct 2020 20:49:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09GKihJm140943;
        Fri, 16 Oct 2020 20:49:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 343pw28mr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Oct 2020 20:49:44 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09GKngiI012585;
        Fri, 16 Oct 2020 20:49:43 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Oct 2020 13:49:42 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201016185443.GA37159@ziepe.ca>
Date:   Fri, 16 Oct 2020 16:49:41 -0400
Cc:     Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <35A86DEC-33E8-4637-BEBB-767202CF0247@oracle.com>
References: <20201008160814.GF5177@ziepe.ca>
 <727de097-4338-c1d8-73a0-1fce0854f8af@oracle.com>
 <20201009143940.GT5177@ziepe.ca>
 <0E82FB51-244C-4134-8F74-8C365259DCD5@gmail.com>
 <20201009145706.GU5177@ziepe.ca>
 <EC7EE276-3529-4374-9F90-F061AAC3B952@gmail.com>
 <20201009150758.GV5177@ziepe.ca>
 <7EC25CA9-27B5-4900-B49C-43D29ED06EB6@gmail.com>
 <20201009153406.GA5177@ziepe.ca>
 <4e630f85-c684-1e56-bb68-22c37872c728@oracle.com>
 <20201016185443.GA37159@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9776 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010160151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9776 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010160152
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Oct 16, 2020, at 2:54 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> On Mon, Oct 12, 2020 at 04:20:40PM +0800, Ka-Cheong Poon wrote:
>> On 10/9/20 11:34 PM, Jason Gunthorpe wrote:
>> 
>>> Yes, because namespaces are fundamentally supposed to be anchored in
>>> the processes inside the namespace.
>>> 
>>> Having the kernel jump in and start opening holes as soon as a
>>> namespace is created is just wrong.
>>> 
>>> At a bare minimum the listener should not exist until something in the
>>> namespace is willing to work with RDS.
>> 
>> 
>> As I mentioned in a previous email, starting is not the problem.  It
>> is the problem of deleting a namespace.
> 
> Starting and ending are symmetric. When the last thing inside the
> namespace stops needing RDS then RDS should close down the cm_id's.

Unfortunately, cluster heartbeat requires the RDS listener endpoint
to continue after the last RDS user goes away, if the container
continues to exist.

IMO having an explicit RDS start-up and shutdown apart from namespace
creation and deletion is a cleaner approach. On a multi-tenant system
with many containers, some of those containers will want RDS listeners
and some will not. RDS should not assume that every net namespace
needs or wants to have a listener.


--
Chuck Lever




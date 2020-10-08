Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197AE2879DD
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 18:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgJHQVR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 12:21:17 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33090 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgJHQVQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 12:21:16 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098GKK7C115461;
        Thu, 8 Oct 2020 16:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=HDGI7hs/0Q85dyKZTmQ/dGGq1KwIe3QWpWMDFNkI18k=;
 b=dU8Xvs9X0uDN08xT9L70P3fUuowamvHPBz25ITE7fqpokDG1Utxpl+yd0pK+SeFBAMLH
 08uoJYCfLviiBR6hAMxKNa7VQ7mzUOxNT8HlRILsMdRF3ll4Gx2SeVk+lpZoEny+cQMs
 q0IFrT2qMshdIi40EjxHw3PtLMefCUAcXqY33YdDgXFl4u0yEv4vou00DXRVOYwb/W00
 yEnh4GHv41mcYpSnxK++lRzgG3SBCQEXEfvOBWeHj63euzEFEJYnCARaW3lyqpHm+tMz
 ogFzCnaYxCLyXg1MavBnzGGvTlma0+JA0+XCp9vLXr3JPP8GbB3DF/AZxM8bPZ/mCYd/ rQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 33xetb8u7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 08 Oct 2020 16:21:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098GEuUT101841;
        Thu, 8 Oct 2020 16:21:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3410k1cbfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Oct 2020 16:21:13 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 098GLCvS001799;
        Thu, 8 Oct 2020 16:21:13 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Oct 2020 09:21:12 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201008160814.GF5177@ziepe.ca>
Date:   Thu, 8 Oct 2020 12:21:10 -0400
Cc:     Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <3AEA60FF-1E16-4BBD-98F1-E8122E85C6B5@oracle.com>
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
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080122
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Oct 8, 2020, at 12:08 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
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

My two cents, and worth every penny:

I think the NFSD listener is net namespace-aware. I vaguely recall
that a user administrative program (maybe rpc.nfsd?) requests an
NFS service listener in a particular namespace.

Should work the same for sockets and listener QPs. For RPC-over-RDMA,
a struct net argument is passed in from the generic code:

 66 static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 67                                                  struct net *net);
 68 static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 69                                         struct net *net,
 70                                         struct sockaddr *sa, int salen,
 71                                         int flags);

And that struct net is then passed on to rdma_create_id().


--
Chuck Lever




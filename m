Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549EC25D01F
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Sep 2020 06:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgIDEBX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 00:01:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36436 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIDEBW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Sep 2020 00:01:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0843xT6N140822;
        Fri, 4 Sep 2020 04:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=uwbndlQtX/R9iqhXaA81qpwMYbw1Zizxo1LCJPUea8w=;
 b=ChtaZ2RfWeJ8+L6k+MlplL+QfZxaOBm7bnhv5ODnopTKuJfiyz29wX7pi1Rh7/0/7crQ
 vsd+s3DBfmz7Bp1DX/vUHZxeCZF8R7X6V/iAsODUZct1JoCaHIPAn4c3Vczt9IfW26kN
 aVOhskKXNJxXQZSYF4n++4uvBzk2s0wGESdpSHmygoyF2Zq5rZJhz72uVXIEAZlghtRe
 zrG0GMhL7fmXVgzkofuIVEwDOzX9Kp5voq4wI1kZQD8DUSeI1YWMNCGs79qk1ETPNfXO
 0erJmiw9lkaDrLMUGa9bgBlQDyt2KFDgAmobztM2n4tj78N+CsokbX9EW/Kxsu5064hc Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 337eercd65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 04:01:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0843t9Kw057783;
        Fri, 4 Sep 2020 04:01:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33b7t08j8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 04:01:21 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08441JWR025586;
        Fri, 4 Sep 2020 04:01:20 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Sep 2020 21:01:19 -0700
Subject: Re: Finding the namespace of a struct ib_device
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
References: <5fa7f367-49df-fb1d-22d0-9f1dd1b76915@oracle.com>
 <20200903173910.GO24045@ziepe.ca>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <a5899aa9-4553-1307-0688-f07f3a919ce8@oracle.com>
Date:   Fri, 4 Sep 2020 12:01:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903173910.GO24045@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040035
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/4/20 1:39 AM, Jason Gunthorpe wrote:
> On Thu, Sep 03, 2020 at 10:02:01PM +0800, Ka-Cheong Poon wrote:
>> When a struct ib_client's add() function is called. is there a
>> supported method to find out the namespace of the passed in
>> struct ib_device?  There is rdma_dev_access_netns() but it does
>> not return the namespace.  It seems that it needs to have
>> something like the following.
>>
>> struct net *rdma_dev_to_netns(struct ib_device *ib_dev)
>> {
>>         return read_pnet(&ib_dev->coredev.rdma_net);
>> }
>>
>> Comments?
> 
> I suppose, but why would something need this?


If the client needs to allocate stuff for the namespace
related to that device, it needs to know the namespace of
that device.  Then when that namespace is deleted, the
client can clean up those related stuff as the client's
namespace exit function can be called before the remove()
function is triggered in rdma_dev_exit_net().  Without
knowing the namespace of that device, coordination cannot
be done.




-- 
K. Poon
ka-cheong.poon@oracle.com



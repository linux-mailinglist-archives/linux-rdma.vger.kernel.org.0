Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D795E88EF
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 14:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfJ2NAP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 09:00:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41944 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfJ2NAP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Oct 2019 09:00:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TCx2Z6085341;
        Tue, 29 Oct 2019 13:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=oiyMqQ6clN9XkaZtbzHKQz6Z8/VKfBhM4I8JBiuWoUo=;
 b=gXWdJvnwuZy92yfpE0xph1X1Pk3sye+loFg5lJtZORocKu5cDaS7PsiXRZzSyzsERlBF
 4gH47TyjztB7CTeByvq7oTsBB4D0jBw0ONV0jE270fQG4T773EolmcwG7FaARzKm1ICF
 itbxlx0DskPg6mdrEMU5KMA+iI7oQdwl5uJvCPsocr/lK2gVxMWMMhvDuLMbfS/iVhzB
 wxtifXvDq1byl6m++NmUdAcTdwuiF8CvZ1W31hjnoYRjEephQZFzAe2+Nlucvu1dDZEX
 4By0Zqk0mw8ob2xAO7LIBhb8THijYGZhCefFkdOmtxK+ob3wSW8Qzp1fz1YenaAuSziG 0w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vvdju95gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 13:00:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TCwoJX070029;
        Tue, 29 Oct 2019 13:00:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vxj8g6h1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 13:00:01 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9TCxxcw018082;
        Tue, 29 Oct 2019 12:59:59 GMT
Received: from [10.172.157.165] (/10.172.157.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 05:59:59 -0700
Subject: Re: [PATCH v2] RDMA/cma: Make CM response timeout and # CM retries
 configurable
To:     =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190226075722.1692315-1-haakon.bugge@oracle.com>
 <174ccd37a9ffa05d0c7c03fe80ff7170a9270824.camel@redhat.com>
 <67B4F337-4C3A-4193-B1EF-42FD4765CBB7@oracle.com>
 <6e586118ad154204ad2e2cf2c1391b916cb4ee54.camel@redhat.com>
 <9B7C9353-39B6-4193-9ACD-AD0FA62E9433@oracle.com>
From:   Dag Moxnes <dag.moxnes@oracle.com>
Message-ID: <aeab651d-d216-2946-11ee-22756fcffd42@oracle.com>
Date:   Tue, 29 Oct 2019 13:59:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9B7C9353-39B6-4193-9ACD-AD0FA62E9433@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290127
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

Sorry for re-opening an old discussion, but I cannot find any final 
decision on how to handle this.

See inline for more comments.

On 6/14/19 7:44 AM, Håkon Bugge wrote:
>
>> On 13 Jun 2019, at 22:25, Doug Ledford <dledford@redhat.com> wrote:
>>
>> On Thu, 2019-06-13 at 18:58 +0200, Håkon Bugge wrote:
>>>> On 13 Jun 2019, at 16:25, Doug Ledford <dledford@redhat.com> wrote:
>>>>
>>>> On Tue, 2019-02-26 at 08:57 +0100, Håkon Bugge wrote:
>>>>> During certain workloads, the default CM response timeout is too
>>>>> short, leading to excessive retries. Hence, make it configurable
>>>>> through sysctl. While at it, also make number of CM retries
>>>>> configurable.
>>>>>
>>>>> The defaults are not changed.
>>>>>
>>>>> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
>>>>> ---
>>>>> v1 -> v2:
>>>>>   * Added unregister_net_sysctl_table() in cma_cleanup()
>>>>> ---
>>>>> drivers/infiniband/core/cma.c | 52
>>>>> ++++++++++++++++++++++++++++++---
>>>>> --
>>>>> 1 file changed, 45 insertions(+), 7 deletions(-)
>>>> This has been sitting on patchworks since forever.  Presumably
>>>> because
>>>> Jason and I neither one felt like we really wanted it, but also
>>>> couldn't justify flat refusing it.
>>> I thought the agreement was to use NL and iproute2. But I haven't had
>>> the capacity.
>> To be fair, the email thread was gone from my linux-rdma folder.  So, I
>> just had to review the entry in patchworks, and there was no captured
>> discussion there.  So, if the agreement was made, it must have been
>> face to face some time and if I was involed, I had certainly forgotten
>> by now.  But I still needed to clean up patchworks, hence my email ;-).
> This is the "agreement" I was referring too:
>
>> On 4 Mar 2019, at 07:27, Parav Pandit <parav@mellanox.com> wrote:
>>
>>> []
>> I think we should use rdma_nl_register(RDMA_NL_RDMA_CM, cma_cb_table) which was removed as part of ID stats removal.
>> Because of below reasons.
>> 1. rdma netlink command auto loads the module
>> 2. we don't need to write any extra code to do register_net_sysctl () in each netns.
>> Caller's skb's netns will read/write value of response_timeout in 'struct cma_pernet'.
>> 3. last time sysctl added in ipv6 was in 2017 in net/ipv6/addrconf.c, however ipv4 was done in 2018.
>>
>> Currently rdma_cm/rdma_ucma has configfs, sysctl.
>> We are adding netlink sys params to ib_core.
>>
>> We already have 3 clients and infra built using rdma_nl_register() netlink , so hooking up to netlink will provide unified way to set rdma params.
>> Let's just use netlink for any new params unless it is not doable.
>
>
>>>> Well, I've made up my mind, so
>>>> unless Jason wants to argue the other side, I'm rejecting this
>>>> patch.
>>>> Here's why.  The whole concept of a timeout is to help recovery in
>>>> a
>>>> situation that overloads one end of the connection.  There is a
>>>> relationship between the max queue backlog on the one host and the
>>>> timeout on the other host.
>>> If you refer to the backlog parameter in rdma_listen(), I cannot see
>>> it being used at all for IB.
>> No, not exactly.  I was more referring to heavy load causing an
>> overflow in the mad packet receive processing.  We have
>> IB_MAD_QP_RECV_SIZE set to 512 by default, but it can be changed at
>> module load time of the ib_core module and that represents the maximum
>> number of backlogged mad packets we can have waiting to be processed
>> before we just drop them on the floor.  There can be other places to
>> drop them too, but this is the one I was referring to.
How can we determine the CM response timeout base on MAD QP recv size? 
As far as I can see we would need
to know the process time for the requests. An incoming connection 
request will be send to and handled by the listener
before the listener calls rdma_accept, do the processing time would need 
to include this delay.
Maybe the best approach would be to let IB rdma users modify the CM 
reposponse timeout, either by adding it to the rdma_conn_param struct or 
by adding a setter function similar to rdma_set_ack_timeout. What do you 
think?

Regards,
-Dag
> That is another scenario than what I try to solve. What I see, is that the MAD packets are delayed, not lost. The delay is longer than the CMA timeout. Hence, the MAD packets are retried, adding more burden to the PF proxying and inducing even longer delays. And excessive CM retries are observed. See 2612d723aadc ("IB/mlx4: Increase the timeout for CM cache") where I have some quantification thereof.
>
> Back to your scenario above, yes indeed, the queue sizes are module params. If the MADs are tossed, we will see rq_num_udsdprd incrementing on a CX-3.
>
> But I do not understand how the dots are connected. Assume one client does rdma_listen(, backlog = 1000); Where are those 1000 REQs stored, assuming an "infinite slow processor"?
>
>
> Thxs, Håkon
>
>
>>> For CX-3, which is paravirtualized wrt. MAD packets, it is the proxy
>>> UD receive queue length for the PF driver that can be construed as a
>>> backlog. Remember that any MAD packet being sent from a VF or the PF
>>> itself, is sent to a proxy UD QP in the PF. Those packets are then
>>> multiplexed out on the real QP0/1. Incoming MAD packets are
>>> demultiplexed and sent once more to the proxy QP in the VF.
>>>
>>>> Generally, in order for a request to get
>>>> dropped and us to need to retransmit, the queue must already have a
>>>> full backlog.  So, how long does it take a heavily loaded system to
>>>> process a full backlog?  That, plus a fuzz for a margin of error,
>>>> should be our timeout.  We shouldn't be asking users to configure
>>>> it.
>>> Customer configures #VMs and different workload may lead to way
>>> different number of CM connections. The proxying of MAD packet
>>> through the PF driver has a finite packet rate. With 64 VMs, 10.000
>>> QPs on each, all going down due to a switch failing or similar, you
>>> have 640.000 DREQs to be sent, and with the finite packet rate of MA
>>> packets through the PF, this takes more than the current CM timeout.
>>> And then you re-transmit and increase the burden of the PF proxying.
>>>
>>> So, we can change the default to cope with this. But, a MAD packet is
>>> unreliable, we may have transient loss. In this case, we want a short
>>> timeout.
>>>
>>>> However, if users change the default backlog queue on their
>>>> systems,
>>>> *then* it would make sense to have the users also change the
>>>> timeout
>>>> here, but I think guidance would be helpful.
>>>>
>>>> So, to revive this patch, what I'd like to see is some attempt to
>>>> actually quantify a reasonable timeout for the default backlog
>>>> depth,
>>>> then the patch should actually change the default to that
>>>> reasonable
>>>> timeout, and then put in the ability to adjust the timeout with
>>>> some
>>>> sort of doc guidance on how to calculate a reasonable timeout based
>>>> on
>>>> configured backlog depth.
>>> I can agree to this :-)
>>>
>>>
>>> Thxs, Håkon
>>>
>>>> -- 
>>>> Doug Ledford <dledford@redhat.com>
>>>>    GPG KeyID: B826A3330E572FDD
>>>>    Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
>>>> 2FDD
>> -- 
>> Doug Ledford <dledford@redhat.com>
>>     GPG KeyID: B826A3330E572FDD
>>     Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
>> 2FDD


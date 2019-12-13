Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32C2A11E8CD
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2019 17:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfLMQzA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Dec 2019 11:55:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46210 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfLMQzA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Dec 2019 11:55:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDGj2no089806;
        Fri, 13 Dec 2019 16:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=kTqP7Z4tqj7+1/EBNfQpgQumKszPpx2zRfMapymHgY4=;
 b=dAkUriqcqmphODV3pd7bEEY5lEmRDhvt+NZ6iH97zc4p9PHt/gT8dClCS6KDQEwGURLi
 viIuvHGI/EKE5nX0i8r1LQRhJq6h146ftleGRXWQUXAZDaNBgHTDw1smlxZKyBD5k0b5
 FtaZo4H38d7VYDPUaU+DgwCf/8Bqy2q42hNG9iXJCIW32EQGi8JMm10sptbUCFQYVCRv
 a0TE+epLv/lL+sleO79B9H3h6FMdePrLnLkT4URkFR7rjcnuRX9Zk7H7tL3AQlg7awvm
 cjrR5txr//lP7jnQIvWK6oK2MemPU3kgWbXKq6OkZAMov9mzFe5hiUbARvmLATOhojJj DA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wr41qt6vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 16:52:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDGihUw040149;
        Fri, 13 Dec 2019 16:52:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wvb99c2p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 16:52:48 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBDGqlL0016535;
        Fri, 13 Dec 2019 16:52:47 GMT
Received: from Marks-Mac-mini-2.local (/10.39.229.5)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 08:52:47 -0800
Subject: Re: [PATCH RDMA/netlink] RDMA/netlink: Adhere to returning zero on
 success
From:   Mark Haywood <mark.haywood@oracle.com>
To:     =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <20191211103400.2949140-1-haakon.bugge@oracle.com>
 <20191211123955.GS67461@unreal>
 <75D5DC74-A39B-425F-BCF7-E0AEBBE464CD@oracle.com>
 <697DC4C7-223E-4321-A304-C950EB93D2B1@oracle.com>
 <20191212114038.GX67461@unreal>
 <AD5EE341-4238-439A-A078-299F00C61B85@oracle.com>
 <20191212121020.GZ67461@unreal>
 <CB8FC366-9983-417D-8280-DD1EB0DCB778@oracle.com>
 <20191212122719.GA67461@unreal>
 <F6B487BC-CEBA-47D5-9E01-B15A8A1902E1@oracle.com>
 <c7d1cb3d-c55f-2bca-c616-6f50a619383b@oracle.com>
Message-ID: <b4147ad1-1f43-e174-669a-500452bab061@oracle.com>
Date:   Fri, 13 Dec 2019 11:51:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <c7d1cb3d-c55f-2bca-c616-6f50a619383b@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130135
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/12/19 9:14 AM, Mark Haywood wrote:
>
>
> On 12/12/19 7:37 AM, Håkon Bugge wrote:
>>
>>> On 12 Dec 2019, at 13:27, Leon Romanovsky <leon@kernel.org> wrote:
>>>
>>> On Thu, Dec 12, 2019 at 01:16:54PM +0100, Håkon Bugge wrote:
>>>>
>>>>> On 12 Dec 2019, at 13:10, Leon Romanovsky <leon@kernel.org> wrote:
>>>>>
>>>>> On Thu, Dec 12, 2019 at 12:59:51PM +0100, Håkon Bugge wrote:
>>>>>>
>>>>>>> On 12 Dec 2019, at 12:40, Leon Romanovsky <leon@kernel.org> wrote:
>>>>>>>
>>>>>>> On Wed, Dec 11, 2019 at 08:31:18PM +0100, Håkon Bugge wrote:
>>>>>>>>
>>>>>>>>> On 11 Dec 2019, at 14:13, Håkon Bugge 
>>>>>>>>> <haakon.bugge@oracle.com> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> On 11 Dec 2019, at 13:39, Leon Romanovsky <leon@kernel.org> 
>>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> On Wed, Dec 11, 2019 at 11:34:00AM +0100, Håkon Bugge wrote:
>>>>>>>>>>> In rdma_nl_rcv_skb(), the local variable err is assigned the 
>>>>>>>>>>> return
>>>>>>>>>>> value of the supplied callback function, which could be one of
>>>>>>>>>>> ib_nl_handle_resolve_resp(), ib_nl_handle_set_timeout(), or
>>>>>>>>>>> ib_nl_handle_ip_res_resp(). These three functions all return 
>>>>>>>>>>> skb->len
>>>>>>>>>>> on success.
>>>>>>>>>>>
>>>>>>>>>>> rdma_nl_rcv_skb() is merely a copy of netlink_rcv_skb(). The 
>>>>>>>>>>> callback
>>>>>>>>>>> functions used by the latter have the convention: "Returns 0 on
>>>>>>>>>>> success or a negative error code".
>>>>>>>>>>>
>>>>>>>>>>> In particular, the statement (equal for both functions):
>>>>>>>>>>>
>>>>>>>>>>> if (nlh->nlmsg_flags & NLM_F_ACK || err)
>>>>>>>>>>>
>>>>>>>>>>> implies that rdma_nl_rcv_skb() always will ack a message, 
>>>>>>>>>>> independent
>>>>>>>>>>> of the NLM_F_ACK being set in nlmsg_flags or not.
>>>>>>>>>> The more accurate description is that rdma_nl_rcv_skb() 
>>>>>>>>>> always generates
>>>>>>>>>> NLMSG_ERROR without relation to NLM_F_ACK flag. The NLM_F_ACK 
>>>>>>>>>> flag is
>>>>>>>>>> requested to get acknowledges for the success.
>>>>>>>>
>>>>>>>> Yes. And when, lets say a legitimate path record response, 
>>>>>>>> containing N positive bytes, is sent back from ibacm to the 
>>>>>>>> kernel, rdma_nl_rcv_skb() think this is an error, due to "if 
>>>>>>>> (nlh->nlmsg_flags & NLM_F_ACK || err)" _and_ 
>>>>>>>> ib_nl_handle_resolve_resp() returning N.
>>>>>>> How did you test this patch?
>>>>>>> Do we have open-source applications which don't set NLM_F_ACK for
>>>>>>> ib_nl_*() calls?
>>>>>> As I alluded to above, yes, ibacm doesn't set it.
>>>>> In this regards, I'm amazed that this patch didn't break ibacm.
>>>> On the contrary. The patch avoids the kernel sending back an 
>>>> error/ACK for every path record / resolve response.
>>> As long as ibacm continues to work with this patch, i'm ok.
>>> What type of testing did you perform?
>> I'll let Mark respond to the testing. The background is that ibacm 
>> was very *liberal* when it comes checking the requests it received 
>> from the kernel. In an attempt to tighten that, Mark discovered that 
>> ibacm received an unexpected ACK from the kernel just after having 
>> sent a response.
>
>
> Without this patch, for every response to a RDMA_NL_LS_OP_RESOLVE 
> request, ibacm receives an ACK with a nlmsgerr error value equal to 
> the length of the response message.


To be clear, ibacm does nothing with the ACK other than write a log 
message that it received an unexpected request. That is why this patch 
has no ill-effect on ibacm and is why ...


>
> With this patch, no ACKs are received.


this is preferable.


>
> If I add the NLM_F_ACK to the nlmsg_header flags when responding to 
> the RDMA_NL_LS_OP_RESOLVE request, ibacm once again receives the ACKs.
>
> Mark
>
>
>>
>> That aside, I think the RDMA NL callbacks shall adhere to the 
>> RTNETLINK conventions, thus, that's why this commit changes the 
>> callbacks and not the  rdma_nl_rcv_skb().
>>
>>
>> Thxs, Håkon
>>
>>> Thanks
>>>
>>>>
>>>> Håkon
>>>>
>>>>> Thanks
>


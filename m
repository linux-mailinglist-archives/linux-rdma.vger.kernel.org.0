Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D031DA57F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 01:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgESX2k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 19:28:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56754 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgESX2k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 19:28:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JNSJDp037309;
        Tue, 19 May 2020 23:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=M5LEFtpHenxdN5OssGmdMFWdxxZp3ytb3DEOBVu2Qp8=;
 b=qjHvey87wAtJXA1UO88cuAbaXB2s9pe7Qv6y6DAOO66xzRtv/KkCvsmRhWMeaKGPP1DK
 ooOKZ5mf/ZoR30gDJy8/fgWLML0QqKms4tkHgGofE9XIDP2zTYsRTW7yodLKRhEWodU5
 +7Tu4p387GZ8aH0vO0uAoSgbdexHjWVKN91S+/2kB7V88R6NzxyNT3EwW14IkJWIb9da
 kPXfcNcwwtu9Vm2EX+e0EFHE0LhcpyXOJbZXS5ifszEGpDOyvmqXksPjvrtS49Lvg3tC
 xrdHjJHMoLalRRSIrDUCMjyPHU7uBej2AKZ6/06csTu+IEdJU9Spsqi/fgfbeQZkdl5l Bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3127kr89dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 23:28:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JNMgFE170219;
        Tue, 19 May 2020 23:28:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 313gj2ffgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 23:28:35 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04JNSWFK018962;
        Tue, 19 May 2020 23:28:32 GMT
Received: from dhcp-10-159-149-244.vpn.oracle.com (/10.159.149.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 May 2020 16:28:32 -0700
Subject: Re: [PATCH] IB/sa: Fix use-after-free in ib_nl_send_msg()
To:     Markus Elfring <Markus.Elfring@web.de>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kaike Wan <kaike.wan@intel.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
References: <b4b66f61-d49e-fd87-87a5-7f5bfff6fd7f@web.de>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <f3eec429-65a7-fbf9-81fa-2df9aa62b98d@oracle.com>
Date:   Tue, 19 May 2020 16:27:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b4b66f61-d49e-fd87-87a5-7f5bfff6fd7f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=3 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005190199
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=3 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190199
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Markus,

Thanks for taking the time to review.

On 5/15/20 9:25 AM, Markus Elfring wrote:
>> This patch fixes commit -
>> commit 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list before sending")'
>>
>> Above commit adds the query to the request list before ib_nl_snd_msg.
> I suggest to improve also this change description.
>
>   The query to the request list was added before ib_nl_snd_msg()
>   by the commit 3ebd2fd0d011 ("…").
Noted, will make this change.
>
>> This flag Indicates …
> … indicates …
Noted.
>
>> To handle the case where a response is received before we could set this
>> flag, the response handler waits for the flag to be
>> set before proceeding with the query.
> Please reconsider the word wrapping.
>
>   To handle the case where a response is received before we could set
>   this flag, the response handler waits for the flag to be set
>   before proceeding with the query.
>
>
> Would you like to add the tag “Fixes” to the commit message?

Noted!

Thanks,

Divya

>
> Regards,
> Markus

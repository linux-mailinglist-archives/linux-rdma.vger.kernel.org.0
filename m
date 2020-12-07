Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CC12D1BB7
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Dec 2020 22:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgLGVJH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Dec 2020 16:09:07 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58804 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgLGVJH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Dec 2020 16:09:07 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7KxKTb158352;
        Mon, 7 Dec 2020 21:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=hb2Fd6RqB2x+11WDtXsB3wXIthnVTGqOEem+hAS2Mr4=;
 b=Na0eJhPCr3CJAcjRwenzKtIWBhlOGmAPrsGs2xbtbA87cNmOIzkzkOG/Y3RJUnbfH99m
 Eqoq1j/ib+Wg6i2NeF6/aZKLCRF61TbBjS/fyPXCBJe8zOG87WTQuB6Sno38DS6ZR2hz
 f7qQB0k8h1PxCjcQl5qNRatpw0Swnm5xOuV98qfl/9qKTFog9yMFZjah1ie+VimMMdDf
 Gc18976H4julit3Nl7Fr4nhdyO5aNLSOsqRjA9yvP5CCDibX83KUoh86AZPr9XrgB3M0
 hfGPCx5b6PzYAPLoOut7RIb6WTRM7mL+BhnDngS/KKecbKduhV0sgnVh7LEtW/Pq2kVq 6g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 357yqbqrfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Dec 2020 21:08:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7L0cK5048403;
        Mon, 7 Dec 2020 21:08:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 358kyrvn0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Dec 2020 21:08:20 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B7L8J6I025389;
        Mon, 7 Dec 2020 21:08:19 GMT
Received: from Marks-Mac-mini-2.local (/10.39.238.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Dec 2020 13:08:19 -0800
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
To:     Christoph Lameter <cl@linux.com>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>
Cc:     Honggang LI <honli@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com>
 <20201117193329.GH244516@ziepe.ca>
 <alpine.DEB.2.22.394.2011201805000.248138@www.lameter.com>
 <6F632AE0-7921-4C5F-8455-F8E9390BD071@oracle.com>
 <alpine.DEB.2.22.394.2011221246230.261606@www.lameter.com>
 <801AE4A1-7AE8-4756-8F32-5F3BFD189E2B@oracle.com>
 <alpine.DEB.2.22.394.2011221919240.265127@www.lameter.com>
 <alpine.DEB.2.22.394.2011231244490.272074@www.lameter.com>
 <648D2533-E8E8-4248-AF2D-C5F1F60E5BFC@oracle.com>
 <alpine.DEB.2.22.394.2011241859340.286936@www.lameter.com>
 <20201125081057.GA547111@dhcp-128-72.nay.redhat.com>
 <alpine.DEB.2.22.394.2011251632300.298485@www.lameter.com>
 <E2349D8B-26AC-469C-8483-A2241B9B649A@oracle.com>
 <alpine.DEB.2.22.394.2011300811190.336472@www.lameter.com>
 <7812B8AB-7D26-4148-8C8C-E1241A1FC8CD@oracle.com>
 <alpine.DEB.2.22.394.2012071021390.53970@www.lameter.com>
From:   Mark Haywood <mark.haywood@oracle.com>
Message-ID: <cd066540-1085-62e8-0995-e1fbd12ddd26@oracle.com>
Date:   Mon, 7 Dec 2020 16:08:17 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2012071021390.53970@www.lameter.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012070136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070136
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/7/20 5:28 AM, Christoph Lameter wrote:
> Looking at librdmacm/rdma_getaddrinfo():
>
> It seems that the call to the IBACM via ucma_ib_resolve() is only done
> after a regular getaddrinfo() was run. Is IBACM truly able to provide
> address resolution or is it just some strange after processing if the main
> resolution attempt fails?



getaddrinfo() is called only if 'node' or 'service' are set. Otherwise, 
'hints' are set and used.

ucma_set_ib_route() (called from rdma_resolve_route()) calls 
rdma_getaddrinfo() with 'hints' set.

Increasing the ibacm log level and then using cmtime(1), I see log 
messages that indicate that ibacm is resolving addresses.



>
> AFACIT ucma_resolve() should run before getaddrinfo()?
>
> Or is there some magic in getaddrinfo() that actually does another call to
> the IBACM daemon?
>
>
>
> What is also confusing is that the path record determination is part of
> getaddrinfo() as well. So both the address and route lookup end up in
> getaddrinfo(). Is IB therefore using the kernel to do the lookups?
>
>
>
>


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2DCCC81D
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Oct 2019 07:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfJEFVV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 5 Oct 2019 01:21:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53380 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfJEFVV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 5 Oct 2019 01:21:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x955IiOg104082;
        Sat, 5 Oct 2019 05:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=YO7N6zrJN20qxv51KNIJ1RDPqPhAFHU5PJDenYif458=;
 b=HfUfxymk0qniVqylT8ZduKZATKDp8DkvqFhsAQHKu9bA7p5biSwG3VMt32YTsFJyMYgM
 /V7VaotUpFN4bGtldpm015CQ8v9MyPTQ2cTP3NltlStStqnVBZAePm84ZKO/44PtoCVo
 28d49wrPjzWBTi4B/o8r7ZWGtWt//eVQ99HnHyS+5F2EOgMkXZ6AL4pIy5xc+NZnoFbI
 7BO4iOP1BpuMXvLRaPMFNBJNfZdoXxqhC3XKaqeLk7Ggww9uBeKScKVTfDyqQDt3MuIN
 YJMjLbHXfpx76GmnTD8rFMyEONBn+CrhoZzoJvrYALznIBIq9EvuNrBCs1hJ4tooHdeV sQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vektr06va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Oct 2019 05:21:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x955I01H078674;
        Sat, 5 Oct 2019 05:21:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vek0an87q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Oct 2019 05:21:04 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x955L2Ng007497;
        Sat, 5 Oct 2019 05:21:02 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Oct 2019 22:21:02 -0700
Date:   Sat, 5 Oct 2019 08:20:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>, Greg KH <greg@kroah.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "Hiatt, Don" <don.hiatt@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [bug report] IB/hfi1: Eliminate allocation while atomic
Message-ID: <20191005052055.GB21515@kadam>
References: <20191002121520.GA11064@mwanda>
 <3452a307-5f87-4587-b289-63ea8bc594b5@intel.com>
 <32E1700B9017364D9B60AED9960492BC72911CA9@ORSMSX160.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32E1700B9017364D9B60AED9960492BC72911CA9@ORSMSX160.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9400 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=921
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910050047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9400 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910050048
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 04, 2019 at 09:09:12PM +0000, Marciniszyn, Mike wrote:
> > 
> > Thanks Dan, we actually got a separate out-of-band email about this. We
> > are working up a fix right now.
> > 
> > -Denny
> 
> Dan,
> 
> This just hit the list in https://marc.info/?l=linux-rdma&m=157022217927143&w=2.
> 
> Can you take a look?
> 
> You mention a change in dma_map_single().
> 
> Do you have an details on that?

Kees posted a patch for that after I emailed you.

https://lkml.org/lkml/2019/10/2/866

regards,
dan carpenter


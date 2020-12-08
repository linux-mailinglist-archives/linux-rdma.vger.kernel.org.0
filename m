Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A486A2D279C
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 10:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgLHJ3R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 04:29:17 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57238 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgLHJ3Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Dec 2020 04:29:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B89PPfg050410;
        Tue, 8 Dec 2020 09:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Lc5Szxs68vXm+bagJPI0i3EhbcYOTqkJ/Kgi+tj9dcs=;
 b=UqA9qNaEUghkrmCXBCZjIyBX7Cb+Ksbg5GSFXMNXVFMgRN/gkR/47qZlrBudiq26AMfo
 zEmZiWwmR/Bp8K6jEmEtmkM/4Xorjsu5YB44LmEiJeTbAkEk3O0q7t2jvqAIzRISQ1R8
 nNJOO/bRkeTKZPtC+PBRX/2u/yEC1ixWhj0jev6HwZWriWwLLrDiF5+ORdDjTU+Gq8G6
 Jplc0vprnlrkZOasiEr7diTj+swT641+noOwj5GHceEOcPQvFOeEHsqkEQYhp3gCQRnX
 yYKDjd8ZZD1xfpI1CCbqAFyn/05CzSIONhUfbcpe53extLqSnRhOZSVTxaM2oXuYx9ix Xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35825m1qgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 09:28:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B89Oe6J125163;
        Tue, 8 Dec 2020 09:26:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 358kysjxbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 09:26:27 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B89QQN9026413;
        Tue, 8 Dec 2020 09:26:26 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 01:26:26 -0800
Date:   Tue, 8 Dec 2020 12:26:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 3/3] RDMA/uverbs: Fix incorrect variable type
Message-ID: <20201208092619.GB2789@kadam>
References: <20201208073545.9723-1-leon@kernel.org>
 <20201208073545.9723-4-leon@kernel.org>
 <20201208075539.GA2789@kadam>
 <20201208085405.GH4430@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208085405.GH4430@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080059
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 08, 2020 at 10:54:05AM +0200, Leon Romanovsky wrote:
> On Tue, Dec 08, 2020 at 10:55:39AM +0300, Dan Carpenter wrote:
> > On Tue, Dec 08, 2020 at 09:35:45AM +0200, Leon Romanovsky wrote:
> > > @@ -336,19 +335,16 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_TABLE)(
> > >  		attrs, UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES,
> > >  		user_entry_size);
> > >  	if (max_entries <= 0)
> > > -		return -EINVAL;
> > > +		return max_entries ?: -EINVAL;
> > >
> > >  	ucontext = ib_uverbs_get_ucontext(attrs);
> > >  	if (IS_ERR(ucontext))
> > >  		return PTR_ERR(ucontext);
> > >  	ib_dev = ucontext->device;
> > >
> > > -	if (check_mul_overflow(max_entries, sizeof(*entries), &num_bytes))
> > > -		return -EINVAL;
> > > -
> > > -	entries = uverbs_zalloc(attrs, num_bytes);
> > > -	if (!entries)
> > > -		return -ENOMEM;
> > > +	entries = uverbs_kcalloc(attrs, max_entries, sizeof(*entries));
> > > +	if (IS_ERR(entries))
> > > +		return PTR_ERR(entries);
> >
> > This isn't right.  The uverbs_kcalloc() should match every other
> > kcalloc() function and return NULL on error.  This actually buggy
> > because it returns both is error pointers and NULL so it will lead to
> > a NULL dereference.
> 
> The actual bug was before, when an error result from uverbs_zalloc()
> was treated as NULL. The uverbs_kcalloc/uverbs_zalloc will call to
> _uverbs_alloc() that doesn't return NULL.
> 

Ah....  Thanks.

regards,
dan carpenter


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D768A19FAE5
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2020 19:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgDFRA6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Apr 2020 13:00:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50978 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgDFRA6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Apr 2020 13:00:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036GmBn6023196;
        Mon, 6 Apr 2020 17:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=9bpfk+yuh590Muza7UCQDedI4J4OneYX6RNfzBmY5Zo=;
 b=s1+YplUUPot3bnUY8eHbQXaRDUOgLivrQNb9Zw0s86rIDwfyxO+YxdcQeGm66QE4uZVi
 iiRGBgN+ELnfLP/9nDjodZnIhYaZ2iikzG1tkiJSHSGwjKjwKne4koNA4qfSc/VVuNsy
 T6Sm5BCTjSTQff/kSdncgpxtLsFukDCNBV0eOSrmvXEoIXuyxTn7o7Pf3MCFVTGiaSg6
 DOLitzGhFEHPU45mbyuDHc6Eg3gzRdq/ALC607GZlWMdxROY1samK0As9FslxfJUhW/4
 wSeZQnwyB+IP8F4s5DGEKlWblY/i1yaQc6dKLkakRRpVDK/i6gAkGDoYaFW3z6gLxhzH HQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 306j6m84y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 17:00:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036GmhCT112006;
        Mon, 6 Apr 2020 17:00:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3073sqa0jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 17:00:51 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 036H0nOL007607;
        Mon, 6 Apr 2020 17:00:49 GMT
Received: from dhcp-10-175-175-117.vpn.oracle.com (/10.175.175.117)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 10:00:49 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH for-rc] RDMA/cma: fix race between addr_handler and
 resolve_route
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20200403193656.GF8514@mellanox.com>
Date:   Mon, 6 Apr 2020 19:00:46 +0200
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        george kennedy <george.kennedy@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EDBCDCC1-E03F-428A-8352-734E3F01B316@oracle.com>
References: <20200403184328.1154929-1-haakon.bugge@oracle.com>
 <20200403185707.GE8514@mellanox.com>
 <1720C7BF-D6E4-4779-B05D-203703042B36@oracle.com>
 <20200403193656.GF8514@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=4 adultscore=0 bulkscore=0 mlxlogscore=366
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=427 spamscore=0
 priorityscore=1501 suspectscore=4 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060135
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 3 Apr 2020, at 21:36, Jason Gunthorpe <jgg@mellanox.com> wrote:
>=20
> On Fri, Apr 03, 2020 at 09:07:10PM +0200, H=C3=A5kon Bugge wrote:
>>=20
>>=20
>>> On 3 Apr 2020, at 20:57, Jason Gunthorpe <jgg@mellanox.com> wrote:
>>>=20
>>> On Fri, Apr 03, 2020 at 08:43:28PM +0200, H=C3=A5kon Bugge wrote:
>>>> A syzkaller test hits a NULL pointer dereference in
>>>> rdma_resolve_route():
>>>=20
>>> #syz test: =
git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
>>>=20
>>> This commit in 5.7 probably fixes this:
>>=20
>> I think it will not. The mutex in 7c11910783a1 ("RDMA/ucma: Put a
>> lock around every call to the rdma_cm layer") will not prevent
>> addr_handler() to run concurrently with rdma_resolve_route(), right?
>=20
> Hmm. Perhaps so. But your patch isn't nearly enough if that is the
> case, you've only considered resolve_route, but it could run
> concurrently with *anything*, with the usual problems.

I was about to argue my case, but looking more into the code I tend to =
agree with you more and more. I thought, at least, that the =
rdma_foo_bar() functions had atomic checks on the state and bailed out =
if the state was inappropriate, but that is not the case all the time.=20=


And the code that transitions the state from FOO to BAR, letting others =
observe BAR, and then conditionally setting it back to FOO isn't exactly =
great...

> Plus addr_handler calls rdma_destroy_id().. Oh wow is that ever
> completely screwed up. Sigh.
>=20
> Probably the simplest answer is to have ucma fail operations that are
> not permitted while an async_handler is pending. I'm guessing the only
> operation that would be valid is rdma_destroy_id?

Yes, that would take care of this class of errors, I agree. On a real =
systems (vs. the syzkaller setup), you may receive (almost any) CM =
packet ay any time, and that concurrency we must handle.

Shall I make a v2 base on next based on this idea, or do you have =
something coming?

>> And, I also suspect 7c11910783a1 to have major performance
>> impact. But, that's a different story.
>=20
> *shrug* I no longer care. The work to fix this in a performant way is
> enormous and nobody wants to do it.=20
>=20
> Until that time we are taking a 'Big Lock' approach to all concurrancy
> problems with rdma_cm as this code is *completely* broken for
> concurrency.

Have you considered putting the hammer inside the cm_id instead of the =
context? Would that allow more concurrency and still avoid the 10ish =
syzkaller bugs?

> Which is why I'm not taking this patch..

At least I made a good explanation of the bug ;-)


Thxs, H=C3=A5kon


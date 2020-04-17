Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2542F1AE0CA
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2020 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgDQPNj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Apr 2020 11:13:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59170 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgDQPNj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Apr 2020 11:13:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03HF8I36079928;
        Fri, 17 Apr 2020 15:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=xa9xmtWpvH2FBhnMESSZVdQ6E6Jn0rjpWUOR2tbuxbE=;
 b=E8GnvtLtAbq9CaKPW3HFkyoE9NPP+emzCB6eKwqbTe5Lo+qlPWP7YJA8atrRi8eY5kaD
 TFbI2cdVkePqSr7kLqyCFSY+B80Xv1BNFTu3GYII3YRBJYn8SJmN9oyPB43L8LcKdorJ
 KPnvlHkg82aRKwW7LgPZr/lwFjF7fo/7hYrMBI12TKRqVzrWd/SCeLCOGRAuutOGqhIq
 btMC0l+6VeysTOChrqCdVZlW1kRnwDaXLePFio7LQvDAjkUArpVvS1s8sqFuZmPs8lfp
 m5uTmqjGYOVbPsTge6flrDsa1YpMz29EJBTXYV/YHYN7aLmXefx4ZvMw33Ym8XQaRVxo XQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30dn95ym7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 15:13:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03HFDLwo166456;
        Fri, 17 Apr 2020 15:13:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30dn91pwja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 15:13:28 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03HFDQ5M002940;
        Fri, 17 Apr 2020 15:13:26 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Apr 2020 08:13:25 -0700
Date:   Fri, 17 Apr 2020 18:13:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     g@ziepe.ca, Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        dledford@redhat.com, leon@kernel.org, colin.king@canonical.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/ocrdma: Fix an off-by-one issue in 'ocrdma_add_stat'
Message-ID: <20200417151314.GV1163@kadam>
References: <20200328073040.24429-1-christophe.jaillet@wanadoo.fr>
 <20200414183441.GA28870@ziepe.ca>
 <20200416130847.GP1163@kadam>
 <20200416184754.GZ5100@ziepe.ca>
 <20200417112624.GS1163@kadam>
 <20200417122542.GC5100@ziepe.ca>
 <20200417130955.GU1163@kadam>
 <20200417134816.GD26002@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417134816.GD26002@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9594 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9593 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170123
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 17, 2020 at 10:48:16AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 17, 2020 at 04:09:55PM +0300, Dan Carpenter wrote:
> > On Fri, Apr 17, 2020 at 09:25:42AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Apr 17, 2020 at 02:26:24PM +0300, Dan Carpenter wrote:
> > > > On Thu, Apr 16, 2020 at 03:47:54PM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, Apr 16, 2020 at 04:08:47PM +0300, Dan Carpenter wrote:
> > > > > > On Tue, Apr 14, 2020 at 03:34:41PM -0300, Jason Gunthorpe wrote:
> > > > > > > The memcpy is still kind of silly right? What about this:
> > > > > > > 
> > > > > > > static int ocrdma_add_stat(char *start, char *pcur, char *name, u64 count)
> > > > > > > {
> > > > > > > 	size_t len = (start + OCRDMA_MAX_DBGFS_MEM) - pcur;
> > > > > > > 	int cpy_len;
> > > > > > > 
> > > > > > > 	cpy_len = snprintf(pcur, len, "%s: %llu\n", name, count);
> > > > > > > 	if (cpy_len >= len || cpy_len < 0) {
> > > > > > 
> > > > > > The kernel version of snprintf() doesn't and will never return
> > > > > > negatives.  It would cause a huge security headache if it started
> > > > > > returning negatives.
> > > > > 
> > > > > Begs the question why it returns an int then :)
> > > > 
> > > > People should use "int" as their default type.  "int i;".  It means
> > > > "This is a normal number.  Nothing special about it.  It's not too high.
> > > > It's not defined by hardware requirements."  Other types call attention
> > > > to themselves, but int is the humble datatype.
> > > 
> > > No, I strongly disagree with this, it is one of my pet peeves to see
> > > 'int' being used for data which is known to be only ever be positive
> > > just to save typing 'unsigned'.
> > > 
> > > Not only is it confusing, but allowing signed values has caused tricky
> > > security bugs, unfortuntely.
> > 
> > I have the opposite pet peeve.
> > 
> > I complain about it a lot.  It pains me every time I see a "u32 i;".  I
> > think there is a static analysis warning for using signed which
> > encourages people to write code like that.  That warning really upsets
> > me for two reasons 1) The static checker should know the range of values
> > but it doesn't so it makes me sad to see inferior technology being used
> > when it should deleted instead.  2)  I have never seen this warning
> > prevent a real life bug.
> 
> I have.. But I'm having trouble finding it in the git torrent..
> 
> Maybe this one:
> 
> commit c2b37f76485f073f020e60b5954b6dc4e55f693c
> Author: Boris Pismenny <borisp@mellanox.com>
> Date:   Thu Mar 8 15:51:41 2018 +0200
> 
>     IB/mlx5: Fix integer overflows in mlx5_ib_create_srq
> 

I was just meant unsigned iterators, not sizes.  I consider that to be a
different sort of bug.  The original code did this:

	desc_size = max_t(int, 32, desc_size);

Using signed casts for min_t() always seems like a crazy thing to me.  I
have a static checker warning for those but I think people didn't accept
my patches for those if it was only for kernel hardenning and
readability instead of to fix bugs.  I don't know why, maybe casting to
an int is faster?

> > You would need to hit a series of fairly rare events for this
> > warning to be useful and I have never seen that happen yet.
> 
> IIRC the case was the uapi rightly used u32, which was then wrongly
> implicitly cast to some internal function,  accepting int, which then
> did something sort of like
> 
>   int len
>   if (len >= sizeof(a))
>        return -EINVAL
>   copy_from_user(a, b, len)

This code works.  "len" is type promoted to unsigned and negative values
are rejected.

> 
> Which explodes when a negative len is implicitly cast to unsigned long
> to call copy_from_user.
> 
> > The most common bug caused by unsigned variables is that it breaks the
> > kernel error handling 
> 
> You mean returning -ERRNO? Sure, those should be int, but that is a
> case where a value actually can take on -ve numbers, so it really
> should be signed.
> 
> > but there are other problems as well.  There was an example a little
> > while back where someone "fixed" a security problem by making things
> > unsigned.
> > 
> > 	for (i = 0; i < user_value; i++) {
> 
> This is clearly missing input validation on user_value, the only
> reason int helps at all here is pure dumb luck for this one case.
> 
> If it had used something like copy_to_user it would be broken.

The real life example was slightly more complicated than that.  But the
point is that a lot of people think unsigned values are inherently more
safe and they use u32 everywhere as a default datatype.  I argue that
the default should always be int unless there is a good reason
otherwise.

In my own Smatch code, I have a u16 struct member which constantly
causes me bugs.  But I keep it because the struct is carefully aligned
to save memory.  There are reasons for the other datatypes to exist, but
using them is tricky so it's best to avoid it if you can.

There is a lot of magic to making your limits unsigned long type.

> 
> > Originally if user_value was an int then the loop would have been a
> > harmless no-op but now it was a large positive value so it lead to
> > memory corruption.  Another example is:
> > 
> > 	for (i = 0; i < user_value - 1; i++) {
> 
> Again, code like this is simply missing required input validation. The
> for loop works with int by dumb luck, and this would be broken if it
> called copy_from_user.

The thing about int type is that it works like people expect normal
numbers to work.  People normally think that zero minus one is going to
be negative but if they change to u32 by default then it wraps to
UINT_MAX and that's unexpected.  There is an element where the static
checker encourages people to "change your types to match" and that's
garbage advice.  Changing your types doesn't magically make things
better and I would argue that it normally makes things worse.


>  
> > From my experience with static analysis and security audits, making
> > things unsigned en mass causes more security bugs.  There are definitely
> > times where making variables unsigned is correct for security reasons
> > like when you are taking a size from userspace.
> 
> Any code that casts a unsigned value from userspace to a signed value
> in the kernel is deeply suspect, IMHO.

Agreed.

> 
> If you get the in habit of using types properly then it is less likely
> this bug-class will happen. If your habit is to just always use 'int'
> for everything then you *will* accidently cause a user value to be
> implicitly casted.

This is an interesting theory but I haven't seen any evidence to support
it.  My intuition is that it's better to only care when you have to
otherwise you get overwhelmed.

> 
> > Complicated types call attention to themselves and they hurt
> > readability.  You sometimes *need* other datatypes and you want those to
> > stand out but if everything is special then nothing is special.
> 
> If the programmer knows the value is never negative it should be
> recorded in the code, otherwise it is hard to tell if there are
> problems or not.
> 
> Is this code wrong?
> 
>  int array_idx;
>  ...
>  if (array_idx < ARRAY_SIZE(foo))
>     return foo[array_idx];

In some ways, I'm the wrong person to ask because I know without even
thinking about it that ARRAY_SIZE() is size_t so the code works fine...

regards,
dan carpenter


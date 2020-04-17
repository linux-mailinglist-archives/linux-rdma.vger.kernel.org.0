Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399111ADE08
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2020 15:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgDQNKT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Apr 2020 09:10:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37714 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729799AbgDQNKS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Apr 2020 09:10:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03HD8ETx152452;
        Fri, 17 Apr 2020 13:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=AjtxkhDippqjmbKdJrsNp6jAtRzGaVDPxncdrI9lIWU=;
 b=bYCVjtMIVEaMujhoppxNMGSyItJ/4HWhQUW5qnWzvTQHp719OMlO+nIixHidV5pY4hgW
 Uf1XyQIGgYYpyyCJdSpTBzi3U/99Ux2F7NTjlbghdWGEU4pg69Gpo0O425LaCOBlgRKo
 lAPQ0G+bdrXxMcON/5qWhiAqiQFJZGsunRSBlTuSXO1vzo9TbaS9WxKA3bjwe0hG7Nkx
 ORRIXROh6ayZSMlGaMQ8/Zbf5woL2Rkf2/DCBUs/MxjRYFageQO9gH48fT1QQIal6mJQ
 XxpKRYW0m0vASjX9esFVgqANCpdOScunQ7MQDJVXc0fRxpDsO8cZjrU2ObqA3OLJCLAu ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30dn95xyyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 13:10:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03HD8Kur082364;
        Fri, 17 Apr 2020 13:10:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30dn9jxru9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 13:10:09 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03HDA7lC009948;
        Fri, 17 Apr 2020 13:10:07 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Apr 2020 06:10:06 -0700
Date:   Fri, 17 Apr 2020 16:09:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     g@ziepe.ca, Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        dledford@redhat.com, leon@kernel.org, colin.king@canonical.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/ocrdma: Fix an off-by-one issue in 'ocrdma_add_stat'
Message-ID: <20200417130955.GU1163@kadam>
References: <20200328073040.24429-1-christophe.jaillet@wanadoo.fr>
 <20200414183441.GA28870@ziepe.ca>
 <20200416130847.GP1163@kadam>
 <20200416184754.GZ5100@ziepe.ca>
 <20200417112624.GS1163@kadam>
 <20200417122542.GC5100@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417122542.GC5100@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9593 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004170105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9593 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170105
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 17, 2020 at 09:25:42AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 17, 2020 at 02:26:24PM +0300, Dan Carpenter wrote:
> > On Thu, Apr 16, 2020 at 03:47:54PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Apr 16, 2020 at 04:08:47PM +0300, Dan Carpenter wrote:
> > > > On Tue, Apr 14, 2020 at 03:34:41PM -0300, Jason Gunthorpe wrote:
> > > > > The memcpy is still kind of silly right? What about this:
> > > > > 
> > > > > static int ocrdma_add_stat(char *start, char *pcur, char *name, u64 count)
> > > > > {
> > > > > 	size_t len = (start + OCRDMA_MAX_DBGFS_MEM) - pcur;
> > > > > 	int cpy_len;
> > > > > 
> > > > > 	cpy_len = snprintf(pcur, len, "%s: %llu\n", name, count);
> > > > > 	if (cpy_len >= len || cpy_len < 0) {
> > > > 
> > > > The kernel version of snprintf() doesn't and will never return
> > > > negatives.  It would cause a huge security headache if it started
> > > > returning negatives.
> > > 
> > > Begs the question why it returns an int then :)
> > 
> > People should use "int" as their default type.  "int i;".  It means
> > "This is a normal number.  Nothing special about it.  It's not too high.
> > It's not defined by hardware requirements."  Other types call attention
> > to themselves, but int is the humble datatype.
> 
> No, I strongly disagree with this, it is one of my pet peeves to see
> 'int' being used for data which is known to be only ever be positive
> just to save typing 'unsigned'.
> 
> Not only is it confusing, but allowing signed values has caused tricky
> security bugs, unfortuntely.

I have the opposite pet peeve.

I complain about it a lot.  It pains me every time I see a "u32 i;".  I
think there is a static analysis warning for using signed which
encourages people to write code like that.  That warning really upsets
me for two reasons 1) The static checker should know the range of values
but it doesn't so it makes me sad to see inferior technology being used
when it should deleted instead.  2)  I have never seen this warning
prevent a real life bug.  You would need to hit a series of fairly rare
events for this warning to be useful and I have never seen that happen
yet.

The most common bug caused by unsigned variables is that it breaks the
kernel error handling but there are other problems as well.  There was
an example a little while back where someone "fixed" a security problem
by making things unsigned.

	for (i = 0; i < user_value; i++) {

Originally if user_value was an int then the loop would have been a
harmless no-op but now it was a large positive value so it lead to
memory corruption.  Another example is:

	for (i = 0; i < user_value - 1; i++) {

If "user_value" is zero the subtraction becomes UINT_MAX.  Or some
people use a "u16 i;" but then the limit increases so the loop doesn't
work any more.

From my experience with static analysis and security audits, making
things unsigned en mass causes more security bugs.  There are definitely
times where making variables unsigned is correct for security reasons
like when you are taking a size from userspace.

Complicated types call attention to themselves and they hurt
readability.  You sometimes *need* other datatypes and you want those to
stand out but if everything is special then nothing is special.

regards,
dan carpenter


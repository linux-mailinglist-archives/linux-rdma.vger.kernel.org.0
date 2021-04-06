Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2A63550C7
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 12:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbhDFKYe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 06:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbhDFKYd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 06:24:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25151C06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 03:24:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l4so21029241ejc.10
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 03:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4en+Aw5cwsZ74vX0NsiZFNSaKcSmhq6EOXBaivzUJ4o=;
        b=AnDWJPkRLc1a1EvgDziDJwB5rHzXiJFFsfOaLT+0XECRjK2a2vuEFcBigK8ZUc4p5p
         7/bVAg97BKORinPxuHTK1M/9wPHZ3uniFELM50Xj1HlxVpEqqAdgVEJyphnNlFJeSIYP
         wvmc61pQMDlbvdvZRF2aKKoKlFaIVImM15pLo3AHgGAXkNLxZFXARYRB+A2VMqdmPmjs
         Wb3vOoFaFYV3Vdc0jjUwMuFCPJy3BsG9kNB1dwvpo5BfnefZbXyuMNWXTMmySmooompv
         AqxIHSrG5sObsCoir5LHNWTsMnw8X2EMMJCEgtMIOuee6j6h2Pp7d+QDyYhWn+RVJj1V
         hNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4en+Aw5cwsZ74vX0NsiZFNSaKcSmhq6EOXBaivzUJ4o=;
        b=W0ZshDvmCplXgoJ/+4bGAXLR6O4RgEkCH3OpLZ+1w9V44TupXar5iAHm4pWu14s/4w
         R/0lX1YVz0MWn4WYwSvgSEKl2965SwJHHXO6j/40kS/NbXqBHeZfJXB3RM1zZVRvVI0Y
         L8ft2cGNuirvMJJIuNq4YZTWM2t5aEYqXaJcOYj0h1PswKj3BiRRpGjM+a2MkiHOFHhb
         tgjrxm0zYqeDJrbcV84+Y6+Kwqp7a+c7wd0kfwkmgxMxykfHDALit0bzcpLG6SxVK4Ta
         ia/GJZpibM5gKYCMAVxhZui5Xv5+KwIO1rGsBZtHmWqxTvpGGW6go+lIa6clqTL+bt/y
         IGkg==
X-Gm-Message-State: AOAM530+JdAjF+HX/1LBeHgsJ4X1qhKCWMrdUFmNeKDlJsCCIej9/33j
        7zvecT48qTm/Ev0tbtsSoK7cuwOgMnWZxhLw9OU0BQ==
X-Google-Smtp-Source: ABdhPJwMHY9sDEeI+QUP6GROHuGD3a7TlP3AWLNN+21d4LyllYAuHB4pUVjDQzF/7wn8XvSdX/nG6s8nQr8JGOemUB4=
X-Received: by 2002:a17:906:c102:: with SMTP id do2mr33177504ejc.305.1617704664790;
 Tue, 06 Apr 2021 03:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com> <20210325153308.1214057-7-gi-oh.kim@ionos.com>
 <20210401183825.GB1645857@nvidia.com>
In-Reply-To: <20210401183825.GB1645857@nvidia.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 6 Apr 2021 12:23:49 +0200
Message-ID: <CAJX1YtZTDboK9pP5KzFB0ZEwXMmOYXANhdyhnuBsqAErvaoUag@mail.gmail.com>
Subject: Re: [PATCH for-next 06/22] RDMA/rtrs-clt: Break if one sess is
 connected in rtrs_clt_is_connected
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>
Content-Type: multipart/mixed; boundary="000000000000e6189305bf4b37ac"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000e6189305bf4b37ac
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 1, 2021 at 8:38 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Mar 25, 2021 at 04:32:52PM +0100, Gioh Kim wrote:
> > From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> >
> > No need to continue the loop if one sess is connected.
> >
> > Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
> > Reviewed-by: Danil Kipnis <danil.kipnis@ionos.com>
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> >  .../fault-injection/rtrs-fault-injection.rst         | 12 ++++++------
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c               |  5 ++++-
> >  2 files changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/fault-injection/rtrs-fault-injection.rst b/Documentation/fault-injection/rtrs-fault-injection.rst
> > index 775a223fef09..65ffe26ece67 100644
> > +++ b/Documentation/fault-injection/rtrs-fault-injection.rst
> > @@ -17,10 +17,10 @@ Example 1: Inject an error into request processing of rtrs-client
> >
> >  Generate an error on one session of rtrs-client::
> > -
> > -  echo 100 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/probability
> > -  echo 1 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/times
> > -  echo 1 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/fail-request
> > +
> > +  echo 100 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/probability
> > +  echo 1 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/times
> > +  echo 1 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/fail-request
> >    dd if=/dev/rnbd0 of=./dd bs=1k count=10
> >
> >  Expected Result::
> > @@ -72,12 +72,12 @@ Example 2: rtrs-server does not send ACK to the heart-beat of rtrs-client
> >    echo 100 > /sys/kernel/debug/ip\:192.168.123.190@ip\:192.168.123.144/fault_inject/probability
> >    echo 5 > /sys/kernel/debug/ip\:192.168.123.190@ip\:192.168.123.144/fault_inject/times
> >    echo 1 > /sys/kernel/debug/ip\:192.168.123.190@ip\:192.168.123.144/fault_inject/fail-hb-ack
> > -
> > +
> >  Expected Result::
> >
> >    If rtrs-server does not send ACK more than 5 times, rtrs-client tries reconnection.
> >
> >  Check how many times rtrs-client did reconnection::
> >
> > -  cat /sys/devices/virtual/rtrs-client/bla/paths/ip\:192.168.122.142@ip\:192.168.122.130/stats/reconnects
> > +  cat /sys/devices/virtual/rtrs-client/bla/paths/ip\:192.168.122.142@ip\:192.168.122.130/stats/reconnects
> >    1 0
>
> Why is all of this in this patch?

I am terribly sorry. That is a rebase error.

>
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index 4f7690137e42..bfb5be5481e7 100644
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -51,7 +51,10 @@ static inline bool rtrs_clt_is_connected(const struct rtrs_clt *clt)
> >
> >       rcu_read_lock();
> >       list_for_each_entry_rcu(sess, &clt->paths_list, s.entry)
> > -             connected |= READ_ONCE(sess->state) == RTRS_CLT_CONNECTED;
> > +             if (READ_ONCE(sess->state) == RTRS_CLT_CONNECTED) {
> > +                     connected = true;
> > +                     break;
> > +             }
> >       rcu_read_unlock();
>
> I assume this is the intended change? rebase error?

It is a rebase error.
Just in case, I copied the corrected patch below and also attached it.
If you want me to send the patch again, please inform me.

------------------------------------------------- 8<
----------------------------------------------------------

From 0362520ca0f974ff787a13b3fc36ff4dbef08aad Mon Sep 17 00:00:00 2001
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Date: Sun, 6 Dec 2020 04:20:58 +0100
Subject: [PATCH] RDMA/rtrs-clt: Break if one sess is connected in
 rtrs_clt_is_connected

No need to continue the loop if one sess is connected.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Danil Kipnis <danil.kipnis@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 5062328ac577..1b75d2e4860e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -51,7 +51,10 @@ static inline bool rtrs_clt_is_connected(const
struct rtrs_clt *clt)

  rcu_read_lock();
  list_for_each_entry_rcu(sess, &clt->paths_list, s.entry)
- connected |= READ_ONCE(sess->state) == RTRS_CLT_CONNECTED;
+ if (READ_ONCE(sess->state) == RTRS_CLT_CONNECTED) {
+ connected = true;
+ break;
+ }
  rcu_read_unlock();

  return connected;
-- 
2.25.1

--000000000000e6189305bf4b37ac
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-RDMA-rtrs-clt-Break-if-one-sess-is-connected-in-rtrs.patch"
Content-Disposition: attachment; 
	filename="0001-RDMA-rtrs-clt-Break-if-one-sess-is-connected-in-rtrs.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kn5vjz990>
X-Attachment-Id: f_kn5vjz990

RnJvbSAwMzYyNTIwY2EwZjk3NGZmNzg3YTEzYjNmYzM2ZmY0ZGJlZjA4YWFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGNsb3VkLmlv
bm9zLmNvbT4KRGF0ZTogU3VuLCA2IERlYyAyMDIwIDA0OjIwOjU4ICswMTAwClN1YmplY3Q6IFtQ
QVRDSF0gUkRNQS9ydHJzLWNsdDogQnJlYWsgaWYgb25lIHNlc3MgaXMgY29ubmVjdGVkIGluCiBy
dHJzX2NsdF9pc19jb25uZWN0ZWQKCk5vIG5lZWQgdG8gY29udGludWUgdGhlIGxvb3AgaWYgb25l
IHNlc3MgaXMgY29ubmVjdGVkLgoKU2lnbmVkLW9mZi1ieTogR3VvcWluZyBKaWFuZyA8Z3VvcWlu
Zy5qaWFuZ0Bpb25vcy5jb20+ClJldmlld2VkLWJ5OiBEYW5pbCBLaXBuaXMgPGRhbmlsLmtpcG5p
c0Bpb25vcy5jb20+ClNpZ25lZC1vZmYtYnk6IEdpb2ggS2ltIDxnaS1vaC5raW1AaW9ub3MuY29t
PgpTaWduZWQtb2ZmLWJ5OiBKYWNrIFdhbmcgPGppbnB1LndhbmdAaW9ub3MuY29tPgotLS0KIGRy
aXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLWNsdC5jIHwgNSArKysrLQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLWNsdC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3Vs
cC9ydHJzL3J0cnMtY2x0LmMKaW5kZXggNTA2MjMyOGFjNTc3Li4xYjc1ZDJlNDg2MGUgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLWNsdC5jCisrKyBiL2RyaXZl
cnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLWNsdC5jCkBAIC01MSw3ICs1MSwxMCBAQCBzdGF0
aWMgaW5saW5lIGJvb2wgcnRyc19jbHRfaXNfY29ubmVjdGVkKGNvbnN0IHN0cnVjdCBydHJzX2Ns
dCAqY2x0KQogCiAJcmN1X3JlYWRfbG9jaygpOwogCWxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KHNl
c3MsICZjbHQtPnBhdGhzX2xpc3QsIHMuZW50cnkpCi0JCWNvbm5lY3RlZCB8PSBSRUFEX09OQ0Uo
c2Vzcy0+c3RhdGUpID09IFJUUlNfQ0xUX0NPTk5FQ1RFRDsKKwkJaWYgKFJFQURfT05DRShzZXNz
LT5zdGF0ZSkgPT0gUlRSU19DTFRfQ09OTkVDVEVEKSB7CisJCQljb25uZWN0ZWQgPSB0cnVlOwor
CQkJYnJlYWs7CisJCX0KIAlyY3VfcmVhZF91bmxvY2soKTsKIAogCXJldHVybiBjb25uZWN0ZWQ7
Ci0tIAoyLjI1LjEKCg==
--000000000000e6189305bf4b37ac--

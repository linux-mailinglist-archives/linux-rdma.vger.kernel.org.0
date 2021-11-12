Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B8844EDA5
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Nov 2021 20:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhKLUC2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Nov 2021 15:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbhKLUC2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Nov 2021 15:02:28 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6418BC061766
        for <linux-rdma@vger.kernel.org>; Fri, 12 Nov 2021 11:59:37 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so15505897otl.3
        for <linux-rdma@vger.kernel.org>; Fri, 12 Nov 2021 11:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OG+083V6tKlKMwvIsmyHrk8e+vRUb8a/Sxa88eSnKj0=;
        b=O8i85ktGDuDVqhJ8U0C65DtMUtxcN+hRP35ZW2gW4bBo6Ua15eZ0o3Tzyb1u9qWjpB
         5gdbZP5JNqajrZsZ21M98RjpG7e0490LqGXGN5FX4ZOgiioiFP5q9mbbV8r+nUKtDZf5
         vKES/7v63sYzobFUz0vmOiqLfxcFxxtTghS9nJkmGK2UZFx42U7SFgUXXssuQwS/yopr
         qV3fJd6/D4Iv5uEqpL+JyxcHgfRzJLjS6h1VRwSy/74r3zpMN9kB6QrOKE5IUfXvFJwX
         /B71OjZm05lT2jmdXVz+46d6Ay0hDOI6adJx0/QTlhFPIkthIus0uWePnBNCya/Qo0tg
         xI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=OG+083V6tKlKMwvIsmyHrk8e+vRUb8a/Sxa88eSnKj0=;
        b=H19VTbe+EeYkjlRg8Us57SXOL2q70Z9UztQRyXD07b76RKPNRp02NRJfyqLmpznNGn
         SZlMUZe11AICjLJciV/Xtr50AHHPGwC+cE494iGWKIqdYxH7uArwtWJFNKO0RP6rvJ/Y
         1OcsEPXYoZWUeghGoCfppsZcw0Qc97ZapuvL16CdugvAZbGP7hjH+5X6JmvkmIpy7oXr
         jHmK/UDYqbaPatncH0GodeYPdCZggBUYOLdRDq4wvx7FtHmPBQbg+rk0iMLw7ZnWofa1
         M+3OwWeNmwH5RH38VIZem1S4hAyyUjtBdn08WGCi6o+JD5XGz2FyBefNlKs+4jUgUVJU
         iU3w==
X-Gm-Message-State: AOAM532miNmVdrbFE5tICym4nNTVFR/qnwWtHFf1U1LS/8t9xGIVTQAh
        s2B6cZx8YbyYWXGYV4hsbrErKJRJg7Tsr2h48qU=
X-Google-Smtp-Source: ABdhPJxmQbN+Zpms3Ous1oc8Pb8g1u9Ru16HJ3PRTDzqK8nvMXaoenDbTHU3Rxu5FaDIiuZWLv2nAe5LfjjAQmbPBok=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr15231925otb.249.1636747176241;
 Fri, 12 Nov 2021 11:59:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:e381:0:0:0:0:0 with HTTP; Fri, 12 Nov 2021 11:59:35
 -0800 (PST)
Reply-To: mr.luisfernando5050@gmail.com
From:   "Mr. Luis Fernando" <drjubrilubaro36@gmail.com>
Date:   Fri, 12 Nov 2021 11:59:35 -0800
Message-ID: <CA+7yYtPB181MxxO4iT5RDpG_5ik32xDUeU3KX1uXGYVkOQ8ATA@mail.gmail.com>
Subject: GOOD DAY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

LS0gDQoNCuy5nOq1rOyXkOqyjCwNCg0K7J247IKs66eQLg0KDQrsmKTripgg7J6YIOyngOuCtOqz
oCDsnojrgpjsmpQ/DQoNCuuPhOybgOydtCDtlYTsmpTtlaAg65WMIOqwnOyduCDqsoDsg4nsnYQg
7ZWY6riwIOyghOyXkCDqt4DtlZjsnZgg7J2066mU7J28IOyXsOudveyymOulvCDrsJzqsqztlojs
irXri4jri6QuDQrri7nsi6DsnZgg64+E7JuALiDrgrQg7J2066aE7J2AIE1yLmx1aXMgZmVybmFu
ZG8gJ+yZgCDtlajqu5gg7J287ZWp64uI64ukLg0KVUJBIEJhbmsgb2YgQWZyaWNh7J2YIOqwkOyC
rCDrsI8g7ZqM6rOEIOq0gOumrOyekCwNCuuqhyDrhYQg7KCE7JeQIOygnOqwgCDrs7TqtIDtlZjq
s6Ag7J6I642YIOydtCDquLDquIjsnbQg7J6I7Iq164uI64ukLg0K7J20IOyekOq4iOydhCDqt4Dt
lZjsnZgg7J2A7ZaJIOqzhOyijOuhnCDsnbTssrTtlZjquLAg7JyE7ZWcIOq3gO2VmOydmCDsp4Ds
m5ANCuyasOumrCDrqqjrkZDsl5Dqsowg7Y+J7IOdIO2IrOyekOyXkCDrjIDtlZwg7Zic7YOd6rO8
IOq4iOyVoeydgCAo66+46rWtDQoyNyw1MDDri6zrn6wuIOuwseunjCDri6zrn6wpLg0KDQrrgpjr
ipQg7J2A7ZaJ7J20IOuLueyLoOydhCDrr7/qs6Ag66a066as7Iqk7ZWY64+E66GdIOuqqOuToCDr
rLjsnZgg7IS467aAIOyCrO2VreydhCDqsIDsp4Dqs6Ag7J6I7Iq164uI64ukLg0K7J2A7ZaJIOyX
heustOydvCDquLDspIAgN+ydvCDsnbTrgrTsl5Ag6reA7ZWY7J2YIOydgO2WiSDqs4TsoozroZwg
7J6Q6riI7J2EDQrshLHqs7Ug7ZuEIOuCmOyZgOydmCDsmYTsoITtlZwg7ZiR66ClDQrsnYDtlons
nLzroZwg7J6Q6riIIOydtOyytCDshLHqs7Ug7ZuEIDUwJQ0K6rOE7KCVIOq0nOywruyVhC4NCg0K
6reA7ZWY7J2YIOydmOqyrOydhCDquLDri6Trpqzqs6Ag7J6I7Iq164uI64ukLg0K6rCQ7IKsIO2V
tOyalC4NCg0K66Oo7J207IqkIO2OmOultOuCnOuPhCDslKgNCg0KDQoNCg0KDQoNCg0KRGVhciBG
cmllbmQsDQoNCkdyZWV0aW5ncy4NCg0KSG93IGFyZSB5b3UgZG9pbmcgdG9kYXkgaSBob3BlIGZp
bmU/DQoNCkkgY2FtZSBhY3Jvc3MgeW91ciBlLW1haWwgY29udGFjdCBwcmlvciBhIHByaXZhdGUg
c2VhcmNoIHdoaWxlIGluIG5lZWQNCm9mIHlvdXIgYXNzaXN0YW5jZS4gTXkgbmFtZSBNci5sdWlz
IGZlcm5hbmRvIOKAmSBJIHdvcmsgd2l0aCB0aGUNCmRlcGFydG1lbnQgb2YgQXVkaXQgYW5kIGFj
Y291bnRpbmcgbWFuYWdlciBoZXJlIGluIFVCQSBCYW5rIG9mIEFmcmljYSwNClRoZXJlIGlzIHRo
aXMgZnVuZCB0aGF0IHdhcyBrZWVwIGluIG15IGN1c3RvZHkgeWVhcnMgYWdvIGFuZCBJIG5lZWQN
CnlvdXIgYXNzaXN0YW5jZSBmb3IgdGhlIHRyYW5zZmVycmluZyBvZiB0aGlzIGZ1bmQgdG8geW91
ciBiYW5rIGFjY291bnQNCmZvciBib3RoIG9mIHVzIGJlbmVmaXQgZm9yIGxpZmUgdGltZSBpbnZl
c3RtZW50IGFuZCB0aGUgYW1vdW50IGlzIChVUw0KJDI3LDUwMC4gTWlsbGlvbiBEb2xsYXJzKS4N
Cg0KSSBoYXZlIGV2ZXJ5IGlucXVpcnkgZGV0YWlscyB0byBtYWtlIHRoZSBiYW5rIGJlbGlldmUg
eW91IGFuZCByZWxlYXNlDQp0aGUgZnVuZCB0byB5b3VyIGJhbmsgYWNjb3VudCBpbiB3aXRoaW4g
NyBiYW5raW5nIHdvcmtpbmcgZGF5cyB3aXRoDQp5b3VyIGZ1bGwgY28tb3BlcmF0aW9uIHdpdGgg
bWUgYWZ0ZXIgc3VjY2VzcyBOb3RlIDUwJSBmb3IgeW91IHdoaWxlDQo1MCUgZm9yIG1lIGFmdGVy
IHN1Y2Nlc3Mgb2YgdGhlIHRyYW5zZmVyIG9mIHRoZSBmdW5kcyB0byB5b3VyIGJhbmsNCmFjY291
bnQgb2theS4NCg0KV0FJVElORyBUTyBIRUFSIEZST00gWU9VLg0KVEhBTktTLg0KDQpNci5sdWlz
IGZlcm5hbmRvDQo=

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6138D15A498
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2020 10:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgBLJZV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 04:25:21 -0500
Received: from sonic310-13.consmr.mail.bf2.yahoo.com ([74.6.135.123]:33806
        "EHLO sonic310-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728595AbgBLJZV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Feb 2020 04:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581499520; bh=6u3qDl6yXWBH9oVBF6VmNFaXPPfmaUEmS0LDo6+oXlw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=J5dKLDfDi56lQeQxTLu6EvFzlMGYE77+iQr5xLKxUL/xh0c0Vh57iP0res/9SMqSpHDBwGGwfVmZZRDB9rLOiv9G8uJN+aqyoiJYD1LFBbZ9L01vHXxK2EttWjJ0EDnsmrrBmBsULki8il9+D9k7FONEh9KbQP+Tt+zDlFcLdZOnA8NQyHDJbEJpO9q9gCEpM3hWgD6kw8BlQzDZvXLSzGtraPJBe/F9EBu6XWWS/cuP57RBrB0P/5HPCoUrI7UTDPvydriuPlcleiA0cjoyGaaJEk/mr6z56WN3Ds5bqSk8WfXK2ALcwxiiyVfzxKTljnRgwqDesG2H7WKwwG6Wfg==
X-YMail-OSG: mdu5LJwVM1kTJTJtU.QodtkUw68C5A_MPMG.I15g11QEKAnaLtUdiivTTW8QKsb
 foLwfXzbqtbDPZKPLj7AKJ4mYMTli0OEOjauViGoOLmhmAvwtiakjuYnJPiVfqWgdMrNj5Eacx3L
 YnDA7bQ7pP7BDaTUZAVs_DNRMFnRuPZ__yjd0CBf3RpoZMlpVf1pYwU1Qj_MWIyqMD7.ttT0zvAb
 Nxew.Kb_hShpWiqEl0KCcfT5kmJbHj1H_I.1PZTgAiqs.nlNHcwZWY2AjvEq39qe6fa0z79OIdxd
 edqXvHjcIrWzjDHYrv.aEavwjDrdpT1N4.tGAKUBRGZ7_m323B1B8YAiRAp3JGrSM7mjjcES.eE2
 PQOumQJyTeTWHfeNCQMbsHUGGYfFqiwrm7gCtxaW_psafHwkVT_RHEsBNY9obtSs1IdV8tu0zCcZ
 SyjZEVSDccEkPZ6pG35vuZXq0QqS7KnKZRqqLvVOgnfIp9nW813FZiV6mISoFeFbkW62Uo.Hle3E
 .uBTzj6cyt_hMX4uWnl4NHqGeLgxXSiL3ehlsznHULri3YpxdpctktyB93lRv4XtjUb9EonESP8n
 UxgKhNAf0PUgnSf7882waQqpPx.HYr4adTn1TX_ei._dGg3yBNdc8v0z9E7LmmEjLIMxUrb2ZaPU
 fb3B039.Dsz4Hl15ip4i730Y94jcqkbQMaOZY2UzZ_9DpN225nGS24O1vjOflXPpX4dsLUrII.t.
 Hv8lhFY7dTJj3vOu65tzIRU3IC_TlMcW2yfWdC1csDT2MrPyMXKz.MZzQu1r1BIEbR_KLJbXsnFr
 n0dB61_tkrK_fykqu3opUIvHgU4UvHoaXfnRm6JOKW_8.uuy2QenfZkUVZMglk2fQ7I3A1Y2S5s_
 SNYRumc8tL6wt6cFYST.9Vb_Vw8HUFA3VWRisM4._rSBMBXo6dkdDm5oLPqKtOv2qf2kBug2Eyi6
 nRCT5oJcgHGYU61pu3npE.ncjkzeycCSR.Cl22GCJ4BJoiCLjHh9T_WDI6mhMJXT8gMoUMh2Aku5
 q4hcrRYvOqHNrC5fpR9h6deFMVYeqqwzRuVIaVlyAcBS.dnF0S8H8fk8UWmJhcqaYaIjUmNGi4HJ
 y7pL7s_j4TKKJUzRBj2JWuzaWH6Sip69NpGxN_Y_PkYXtDEpmZ08vDnRD3e.6pLLBGDoihL7kp.d
 seEEe0dWtL81YVeIblChqJ1P8NosWiqu3fetD.s.zcze6..3f2PtyeEmf1mIytxSZg124oSom3_h
 gbBN6f6gVa6M4f0lgUovnuG.m.1zJkBCVvZ5y0VuXUmbNTfXmhsNmuHqMkTEde8ouuspkKGjF3Mo
 ikYo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 12 Feb 2020 09:25:20 +0000
Date:   Wed, 12 Feb 2020 09:25:17 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh222@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <1853831241.1328184.1581499517784@mail.yahoo.com>
Subject: BUSINESS TRANSFER CO-OPERATION.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1853831241.1328184.1581499517784.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



Dear Friend,

I am Ms Lisa Hugh work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment and the amount is (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me after success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other .

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa Hugh

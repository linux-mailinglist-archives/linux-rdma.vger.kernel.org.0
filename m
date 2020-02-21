Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD9DC167B6D
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2020 12:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgBULAC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 06:00:02 -0500
Received: from sonic302-2.consmr.mail.bf2.yahoo.com ([74.6.135.41]:42311 "EHLO
        sonic302-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbgBULAC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Feb 2020 06:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582282800; bh=vdONypa+pmkSCxMpJ481zxWsfmYXdIIKq3bhYsM38cE=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Cp8rs79z9w/+pYI9Dd8526obR+EBt9S+ugCQZL/fJu/vVuPEOCHK8KrwkJoyT8kJkPENhc8PYUXEKdVAoO9yzqBYCBVZcetBX7GSnqskTVN99ckj5QUTLNw6gWpAShKRdX8gGTqexOKvIHb9C0QM1uS0qnuNwII1oTgfC0V6fEsQO2+keeazSxk4CGtu+KaBIvlgTK+87EmKKeTzTUolsnHANzipLyKK30vcKSIwpzkHBa0A20cZGfruAEBKgheoflfnNiL7MssHwQ2rMfDH4Wn29Odc0XLpGw3Vls5bv+YRSVumusCOuBu5nq4RWCFWc993j9zcN8OCV96TpVkTnw==
X-YMail-OSG: 7.qQ_.oVM1mO3OR_WseWHYFqxRGr0I1ikivAZSNILVs9i64fXmPR3wK9V9.3NsK
 w3Rix7LUCLB0tL0J1RcMSyJYlVxQV_RTLqjHyssJFcXqVTHaUx65enTYrqhmWX2IYLoVIZIF3dpJ
 mzswpfOPlJmSwiStjr41gTv54RaXMnvpP1oZB6mX4tJwSiUK34_fdSMcJ3O8LD5YLp1oDpz3XQXs
 lPodnth4o.uh_EFiDzr7gh4embQ0wfi8m7OHQl0osvOqHuHDt8VgR8EySdQeNELy3FQKSSWrROHk
 ynw2cPrEfnIT9YGfXzAa0B9cJ3Xm75kIV7okXDe0j5WguREykLo.hQvCyTJuuKhBV1kCCeklAl7s
 85HLSwN6Dt8Kzp0SXDiTlhpZ__PDq.DNLMsPlghzRvs_.tODQBSknPuTmqOsLu0KNfkq.ePViKNw
 IpKnMiki7Gh05NXj7GB.7KAkUsDT2Xo6SDfEXlAazrGrHugOcZM_Qg2u8qcTU2qw_JAU2IV_cAnQ
 EweQBIIu.gdEGncUVVUPLyl6oPUgKGYK1_ysj_zTXBdEqvqCc9bf3naZMpl5p3k4rgOjbh12rvad
 SpG3KV1GcBefQM1jMKDwrxJp0oJ982EI3yNUZt5Vq64JVKoNak4qzFhOMN8TuksizSwj5XVEy9o5
 3.GSUFZ43Of_OwNvXBJiyWmha1ImLarG5r_c2fEPBpa6HfVIE2syYPMbTU5JIv2o0XUAIvkpEVwV
 z7IAqHwTWkAtfj7C9QcBsim12rRXiKA.9uIComgMHZJ5mduLdjh5SB7f_i_pkISdbuEqj2d7gmFQ
 3W2desJywURjhB1T.cWgl_34hLATT9Z0dWjIiZgyXXYFxLjPIRaOrZO2wilSafwvhM0Q6jxRrbWr
 dGv5tsb9.hR_gKefBGUSGvwl_ewleTYIGNHCO5u29W3yfx_sVJHCEUnU2j2dBC8LtP8cHG_HeAr8
 F8Ar11KC41xn.kf6aAsy6u1vAsD1gL5VWMI1Y5BwDUEmdjZbSuE_Z5QCHa71Hg91VxAHhlPBABbz
 TiZtXABmiwS9mtsKRAbdU4rJ08ZiN1rJxpS_OoftunI0vA5rHBkAPinRx1TQsim4Nfib6SmUXb4K
 3ahvp9OlNC2DzCFH1nZ4PT.s8SNrHm2DVADWIqbw_dqtSF34pHwm44fmlottcoh65QGWALWNc1mN
 w7zIiB.12E6Eu_utdS9TDJ1CcdJYW2DuFRJ0UpLVVGQOMeXE4HfhP89Kd5bVEoflZVn49z5X468x
 rTcUOLxquIij.mpF0eK.AQ1ykoyvR.1cMlhMtiBfLzfnY__ac8yax54thw3h5h.SmZtyWoUpiZP0
 aJCcf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 21 Feb 2020 11:00:00 +0000
Date:   Fri, 21 Feb 2020 10:59:55 +0000 (UTC)
From:   Mrs Elodie Antoine <mrselodieantoine@gmail.com>
Reply-To: antoinm93@yahoo.com
Message-ID: <1980516529.4491446.1582282795681@mail.yahoo.com>
Subject: Greetings From Mrs Elodie,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1980516529.4491446.1582282795681.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:73.0) Gecko/20100101 Firefox/73.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



Greetings From Mrs Elodie,

Calvary Greetings in the name of the LORD Almighty and Our LORD JESUS CHRIST the giver of every good thing. Good day,i know this letter will definitely come to you as a huge surprise, but I implore you to take the time to go through it carefully as the decision you make will go off a long way to determine my future and continued existence. I am Mrs Elodie Antoine
aging widow of 59 years old suffering from long time illness. I have some funds I inherited from my late husband,

The sum of (US$4.5 Million Dollars) and I needed a very honest and God fearing who can withdraw this money then use the funds for Charity works. I WISH TO GIVE THIS FUNDS TO YOU FOR CHARITY WORKS. I found your email address from the internet after honest prayers to the LORD to bring me a helper and i decided to contact you if you may be willing and interested to handle these trust funds in good faith before anything happens to me.
I accept this decision because I do not have any child who will inherit this money after I die. I want your urgent reply to me so that I will give you the deposit receipt which the COMPANY issued to me as next of kin for immediate transfer of the money to your account in your country, to start the good work of God, I want you to use the 15/percent of the total amount to help yourself in doing the project.


I am desperately in keen need of assistance and I have summoned up courage to contact you for this task, you must not fail me and the millions of the poor people in our todays WORLD. This is no stolen money and there are no dangers involved,100% RISK FREE with full legal proof. Please if you would be able to use the funds for the Charity works kindly let me know immediately.I will appreciate your utmost confidentiality and trust in this matter to accomplish my heart desire, as I don't want anything that will jeopardize my last wish. I want you to take 15 percent of the total money for your personal use while 85% of the money will go to charity.I will appreciate your utmost confidentiality and trust in this matter to accomplish my heart desire, as I don't want anything that will jeopardize my last wish.


kindly respond for further details.

Thanks and God bless you,

Mrs Elodie Antoine

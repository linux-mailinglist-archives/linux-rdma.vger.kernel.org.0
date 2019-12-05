Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928D2114671
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2019 19:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbfLESAd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Dec 2019 13:00:33 -0500
Received: from sonic301-3.consmr.mail.bf2.yahoo.com ([74.6.129.42]:38848 "EHLO
        sonic301-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729909AbfLESAd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Dec 2019 13:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1575568831; bh=zPC9p8T5S06DA73PD5F75wViZ/EpBpeYylTS7OqjCU4=; h=Date:From:Reply-To:Subject:From:Subject; b=lkLM6V6mUH7CUUGUxB6VNBoIyR9CwL2baaJG1X3YweaYMCX5sx2UnHoL68PMpF0KmZBXCQg9yIPV3KZo+9f1m+G4kZ+b73ZxKn2NNh0l5aBkjDVkTeejk9SCci/gcmGKCNDiJtkyzn9RBaoa96HJ94sz2xFXh0H1XaQXKUwMh3pX9cAHfEG/Fj5Hi17R29WhfWvHU8f8CJvUxCyIyYuEaC8G+rZC0HnmoxV135OaslFNlHc9rdSlszF0QC++Sn55s6Z/VOCN+Lti1DqF5q/MWZGZv7hY71iTi4YM4DUgfRYUHfVkxP40LydtgTWbJ7lw7ehMlk35lSb12Vf2WNquCw==
X-YMail-OSG: KNsbVJcVM1mEMPfKtZmaTgmYqEa0kn4p4upKvdSBGfZO0x3ALUBHdMAtniXc_s8
 7vNWjkeJmlpj0NNhwphjb2wgxDH4Banl94mDFO.T6muSVgSfLsNtF2aG59e3aJ.44kNnUrrlA6AW
 1qWrDJTwr2qqjPj7X0rByNM_BdXLdPhc6xNCmKK6uj5OJU6ZLWNQW5_ga.hM6i1otip_qPyyYvtQ
 h3xI1C0k0OK68b9.Dd4eWGgzngMIckaOHeXaRcUtzaCqONwhc0TpchBAzk.QtVdBhGzfH8AtdDRs
 41JhvBzJIqycJjM2UkRpIouYKct2YW4aXJfnu67WgsalBNfm5xKlHFeL6VJAyim0L0tuQZy.f6sw
 9QL.2YWNC6dQzRWskd70lPcn0bNTfvujKceShzb_2p.4rCCHlaU5N7k9o5iyBFmErnoEtHJVflk4
 6FAsdlBumVNcRlrc47zTX1cEy1ccZn0PtJJuvnPNTvgbxNNvJrlcXgvreiiLdFRwJfGzaNQ8tvmZ
 CotB3FPbVVrDjw0cEv2KJUKOfxzqw.T9xTl.7GVK7utSA0pkTBFIWWo1NJe3.EbGzowSiRsO7unQ
 DX.jHP1HFGcOFWFBwMoAUKhcCVL4HD00zcAMq8iIQT6DAVbSucIGEE4J2TVa.7aoeSspzD4kGiIX
 shpGkZqojcrDu16uHkTV3MHSgBJbCce8j379zymQcqD45KXfDYD7ieZvUKLhxW1IwAgjQzZgO.nf
 mvC7zpDchFd9StHI4EtDQDHo7LBEFwwWMmtEOYo6BQcscKBsXUQtgvsmC5HC1D0yO8ZW8cp86Ak2
 EJNg_Qhz8urYESTJo21esubGwjBHpLwe5UF8dH2c6hT3uZrx4xFKTlEFRltjGjGU3NwlxOv0n4Ua
 OtkI3Ok9vk7IBMIll_TLE3Ty_KtrTStdCnz5bzEu5u_auB.lKx5KkhaB2.NS5HmQQQNL3wlM_SQ9
 3.mdcpOqqzFC7J6kNyjyBXQdCwftFiFdg4TdCqqlJg9dwEMbht.eWAUR_fzLs72kdLW8AB0JyN7W
 X4KjXaL.66bBvn1CKolNFq0zfYe7cVWcVyr46aFRlOBmjmDUl4mLNxFZHXA3esD_3x9zb72Ct.tP
 5tNfgIinWI2crXrKKmK.2TdBkRS3fDkAHEuJvZx4NWhkHMkTAYvGvuHWTyqpqwMYarn6bsmWZZ5B
 rrHk8tXCH4b.fKteXlRUFy_0dS85B1pDy1kTLWa1dBXnGd2jFrS..hM4BqI2v4qKrA7ia6RLDiur
 vcbeA.4N3UQwm8hBc0.y5Gz4BslbpHXfFIXSABvIKCzEh3drvYX2nJwBggxMbvr9FY5WGf8Mxqiy
 IBr7LJaEbog--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 5 Dec 2019 18:00:31 +0000
Date:   Thu, 5 Dec 2019 18:00:27 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh222@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <691108676.6159901.1575568827372@mail.yahoo.com>
Subject: I NEED YOUR HELP FOR THIS TRANSFER.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



Dear Friend,

I am Ms Lisa Hugh work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me forsuccess.

Note/ 50% for you why 50% for me after success of the transfer to your bank
account.

Below information is what i need from you so will can be reaching each
other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa Hugh

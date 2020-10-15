Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5A328EF86
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Oct 2020 11:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbgJOJqP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Oct 2020 05:46:15 -0400
Received: from sonic306-1.consmr.mail.bf2.yahoo.com ([74.6.132.40]:37446 "EHLO
        sonic306-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388814AbgJOJqP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Oct 2020 05:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602755173; bh=vwEPMXxlnKui2A6anShyb2NpJ3D8JWCHQa2USlPuv/A=; h=Date:From:Reply-To:Subject:References:From:Subject; b=S7/JcU0b7GYJNxlweQzhrEh7cKZ3NofO9W+5AfvpVMogsZVa/lTMxq+cmkJik2JH0/OQAgB7qHpfBB0ARct8jQjc03uvP9UxzvOVhFYBroog7E83kaNcXvk0bQQyC6jhcEaGF8w1t2DCXiBgyFT+4wjjG/+GA2c7rmpNdJwfvnGdXlDlQCrLJJQ0Fqmm3lxGtZOCkEezghyTgZFomEHGvtYrV0nrp3CBQacIGlTm/GhIb2Wv5F0xBcxp1V1bGBa0QKzCJQFGy7UGj9guI11TgeNVw41XLpx1c6ylU89VNy9NcJngoxm2pFCfy6nXOeoOumVOM99xntfLOFbJe3dxPg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602755173; bh=MvdxIb3T0FrQwVsUTFIM5JIIvjW1lcfFt0hKjoiX49f=; h=Date:From:Subject; b=Nsz/Lrq+zNwa0WeULtMnlF9jls6k8SkfgiNujvgQb9dOGWAXGMKKT07DrnMir4aYPhdXKpF4NyFyCx6RnL+KEHRrPejwyOAM+Hp9yjUMWlRzBR2DcxG99WQFxIVcNy+UK0vgZMknDXSbtGYj9CC0ILsEJsV64GJFtyX+zFe6JhMdjlc2sfCI9kmdsEsfILtjThEVuJonRhV4ppCBBUnHPviz+GCafSoqNkWdSXfMCmSoP6KR/BD8rnbxx+82A9Xnn5+YMtTjW1c/fQ4WnTPCk9o2oG3bJBmC67p69C34fd1hqkMswbBSuzjA8+X5ygPyrE9yXhj0iFHeFdzqkmSUTQ==
X-YMail-OSG: CUjXXyYVM1kaUQ3vQqYQCcYMlpgILknq6FNXtPvwQ9q1MDtSXJberjQBysCa2Yj
 XX_a9zREZD9rsCNl_O1LovXv_1XGVNNKkyI9VfRvrvhShJcObUSnhkszA0mZZ3utanXXE6MyDRHU
 PN3gOFyOhPw2pLPxQHzM4l1fNRKmc1fakvWZZj4X2heMIkeBz23l6FDi2ibvPrczfewpW_70OsZ1
 ybN5Y12lltAcRi7jDP3iRMSuwdJRXP2hdiCv1HegoPn0MsnVlaodpyDY6PkUxSME2DWv5YkVsxOi
 s3pALZcKB65096oS57FdTzGicOaPd2HPTgITim3wElEaV0TnrN_iGdfk.ekUQF17V7hiv65s02gn
 tYrcQ6y.y81cXT78NcG12iEHOCnRFqeZSdIuWVJdv6IsSRdSjdRcmotM_MuXiiklel8Tg2duPNM.
 txt9S1Px5P3CZDWIODCBXm3Zwq.BZnnFKxVpIz3aK6X3aA7OFZIToG7JF6bJ5l7sBb1IVJHUlDMh
 4GOxLcbzrmqs27DtwfKrMnvfUVHHqcCtAEGup7wSw2VQYiIkTw97zuN_2b5OZzdO6AwywU0CFNA2
 X5JftVKyiKBGkd6jpE8BuR8vDIiN1jOnZ_xNSDDhu8oTnv7_kgw769LE356HYbWiSaZj3QpOOrNk
 cNXRG_PXMAd9c3D036OYPSqCVW94Gotn.IqFdCTmgAJLW5iJgSDg_5GCxl0aoNqYZ73bR12qsqfj
 mWKBcMGKqQAw2k0GjNOrdR80NODhcpyOXzHUVo5ge4FsO4qSrZfKXCcjWzKnfrcAB3bAc7lESTlX
 RzdHeoBrZdRkSl7idWHZvCUrJqupRydPLWdwKOicQkwmqRxO.GfvwT9cdpgbsrMn0xJ8mokdfcuS
 jTEOy2k55xW3ydWSpUDrC2syXxp09PFugcbLwROJYfx47Aefh9I8EVqILBqJqVLp7DgRVxERbspL
 e09JZ._9QLDJxCSJ.HeqNyiGnzKa_uSDfRnsvwc0JuNhyz995YHYgXNzYCNhqfrm8X8hWaOJS5F8
 mL5Wpf6idSgjCJaJ6KSjdLmh3VfFRGrL2yNsTa5dvVKOrXb7ztiksQdRwgJJdSjrYzsiNdKzPx7h
 TK5svd7epaFZzzyDUajkfNd6OYtrqhr6nnBGz4.2AbdKd1SYAp5Ad7rCn6on78jEPhUkFdH8pIQO
 7TIBQ_Xq5D_mLt7Il0sAYE12Ok9FAHnWJXIR.ec7BLbe_tqKSzxalJMHr86.gXu_7aodFfrbdgjQ
 ZUnnpdailHJiIrffL2udC3H5oPUHmWkOFkjSv6HgBHi6B.6EVOVcnxo9Bz.BqyNEs57dbxJLXvVd
 B3ghwaIGK.dQqoFIud3RsDPHsB0e1wKakGzy7K2d5I65wAiuhHH5nIMCoXP4DCjHwx0HV1u9QhXm
 3IjUcZt2nAitrTU0Lwf07yQwmahzc_eLF2dZt0OdnI3.WpEQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Thu, 15 Oct 2020 09:46:13 +0000
Date:   Thu, 15 Oct 2020 09:46:13 +0000 (UTC)
From:   Elisabeth John <elisabethj451@gmail.com>
Reply-To: elisabethj451@gmail.com
Message-ID: <1403458753.675832.1602755173572@mail.yahoo.com>
Subject: Greetings My Dear,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1403458753.675832.1602755173572.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16845 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Greetings My Dear,

I sent this mail praying it will found you in a good condition of health, since I myself are in a very critical health condition in which I sleep every night without knowing if I may be alive to see the next day. I am Mrs.Elisabeth John a widow suffering from long time illness. I have some funds I inherited from my late husband, the sum of ($11,000,000.00, Eleven Million Dollars) my Doctor told me recently that I have serious sickness which is cancer problem. What disturbs me most is my stroke sickness. Having known my condition, I decided to donate this fund to a good person that will utilize it the way i am going to instruct herein. I need a very honest and God.

fearing person who can claim this money and use it for Charity works, for orphanages, widows and also build schools for less privileges that will be named after my late husband if possible and to promote the word of God and the effort that the house of God is maintained. I do not want a situation where this money will be used in an ungodly manner. That's why I'm taking this decision. I'm not afraid of death so I know where I'm going. I accept this decision because I do not have any child who will inherit this money after I die. Please I want your sincerely and urgent answer to know if you will be able to execute this project, and I will give you more information on how the fund will be transferred to your bank account. I am waiting for your reply.

May God Bless you,
Mrs.Elisabeth John.

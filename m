Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334874F06EC
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Apr 2022 05:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiDCDHz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 2 Apr 2022 23:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiDCDHy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 2 Apr 2022 23:07:54 -0400
X-Greylist: delayed 338 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Apr 2022 20:06:01 PDT
Received: from mta-out-05.alice.it (mta-out-05.alice.it [217.169.118.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68C612FFE8
        for <linux-rdma@vger.kernel.org>; Sat,  2 Apr 2022 20:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alice.it; s=20211207; t=1648955161; 
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Reply-To:From:To:Date:Message-ID:MIME-Version;
        b=bXIZQ7j9NdgGAwq8TlZddd/LMf/NYzipXSLNKuoqHM1j9Nv6NPuxduRZ/JQfh0n80/ECUxDZE3cQyiIGL2m5B4EhH/BQQhDf5Z9c0G/aYRvB0WxayiijfIlKtAk1AsTZbF8bRquF2HRPslRVnUT5up5Gry89FVOMipgazkmChKqrTeGL7zFY5UOKyOVDUHjCp3Gg+NQjXQ4zGbhP5SUWGeb4V62CvMLxSChAhgMluS0E5192Debk5kxzz8PLk90yQWJHonBq8ZpUQ4BUI8b632DYyhKkstlJIVDD9TG6jByCR0ymeLKeKMmimkrCx36DRHno7ID1m8Gp5g/dsnLLFg==
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudeiledgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvffgnffgvefqoffkvfetnffktedpqfgfvfenuceurghilhhouhhtmecufedtudenucfgmhhpthihuchsuhgsjhgvtghtucdluddtmdengfhmphhthicusghougihucdlhedtmdenucfjughrpehrhffvfffkggestddtfedttddttdenucfhrhhomhephggvuchhrghvvgcurghnuchofhhfvghruchtohcuihhnvhgvshhtuchinhcuhihouhhrucgtohhunhhtrhihuchunhguvghrucgruchjohhinhhtuchvvghnthhurhgvuchprghrthhnvghrshhhihhpuchplhgvrghsvgcurhgvphhlhicufhhorhcumhhorhgvucguvghtrghilhhsuceofhgpphgvnhhnrgesrghlihgtvgdrihhtqeenucggtffrrghtthgvrhhnpeehjeetgefhleetiedtkeelfffgjeeugeegleekueffgfegtdekkeeifedvvdffteenucfkphepudejiedrvddvjedrvdegvddrudeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegrlhhitggvrdhithdpihhnvghtpedujeeirddvvdejrddvgedvrdduledtpdhmrghilhhfrhhomhepfhgpphgvnhhnrgesrghlihgtvgdrihhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqrhgumhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 60
X-RazorGate-Vade-Classification: clean
Received: from alice.it (176.227.242.190) by mta-out-05.alice.it (5.8.807.04) (authenticated as f_penna@alice.it)
        id 623DD3C500EA866B for linux-rdma@vger.kernel.org; Sun, 3 Apr 2022 05:00:21 +0200
Reply-To: dougfield20@inbox.lv
From:   We have an offer to invest in your country under a
         joint venture partnership please reply for more
         details <f_penna@alice.it>
To:     linux-rdma@vger.kernel.org
Date:   02 Apr 2022 20:00:20 -0700
Message-ID: <20220402200020.41F2E0D44E5EF88A@alice.it>
MIME-Version: 1.0
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,BODY_EMPTY,
        DKIM_INVALID,DKIM_SIGNED,EMPTY_MESSAGE,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,MISSING_SUBJECT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [217.169.118.11 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5051]
        *  0.0 RCVD_IN_MSPIKE_L4 RBL: Bad reputation (-4)
        *      [217.169.118.11 listed in bl.mailspike.net]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [f_penna[at]alice.it]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dougfield20[at]inbox.lv]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts and no
        *      Subject: text
        *  1.8 MISSING_SUBJECT Missing Subject: header
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blacklisted
        *  0.0 BODY_EMPTY No body text in message
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


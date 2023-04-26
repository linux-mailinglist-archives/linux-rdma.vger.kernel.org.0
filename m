Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045446EFE26
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Apr 2023 02:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242667AbjD0AAG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Apr 2023 20:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242613AbjD0AAF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Apr 2023 20:00:05 -0400
Received: from mail.heimpalkorhaz.hu (mail.heimpalkorhaz.hu [193.224.51.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2623AAA;
        Wed, 26 Apr 2023 17:00:04 -0700 (PDT)
Received: from mail.heimpalkorhaz.hu (localhost [127.0.0.1])
        (Authenticated sender: alexandra.nagy@heimpalkorhaz.hu)
        by mail.heimpalkorhaz.hu (Postfix) with ESMTPA id 590983835793E6;
        Thu, 27 Apr 2023 01:42:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.heimpalkorhaz.hu 590983835793E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heimpalkorhaz.hu;
        s=default; t=1682552547;
        bh=W6ZSce0cCVgkn0l95t889AY595zUPLw5BzNOdwdHQs8=;
        h=Date:From:To:Subject:Reply-To:From;
        b=rSOFuH1+D3Yx+tc0ozWZjAa6+/5dR/pDSEIyflsacVJK/BfZqqI/3YRN5ZCNBvO/a
         5E+eLQne/TJWSxa+ScUP+zNKNYtLeByfrPJA5Ie+sGdQ09hw27V0ugwrFFGcyqi/EP
         ASefUBmG1w0u2pXYW5rxrS+2PC13/TF2nYzoehP5/57HzhwBnIII01bMRBD7DqZYTX
         Fwy+O5JhMMOAGhpiF8eVR5HoTi4HN7Jxg9nG4dUEfLM1EyzX3B0ZNAv+b8ENWFgNrB
         wNrqKb3KxxQqqQDcQvht6nZuLUocPhC5lNmyggZK+JIxtX3UkFlOr8fg8pY/1FSBuQ
         rqvFdBY0aocsQ==
MIME-Version: 1.0
Date:   Thu, 27 Apr 2023 07:42:27 +0800
From:   "M.K" <mk@heimpalkorhaz.hu>
To:     undisclosed-recipients:;
Subject: =?UTF-8?Q?=E4=BD=A0=E5=A5=BD=E9=99=BD=E5=85=89?=
Reply-To: kmarion709@gmail.com
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <371937737509fcd13f7dcbf486f08220@heimpalkorhaz.hu>
X-Sender: mk@heimpalkorhaz.hu
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 590983835793E6
X-Spamd-Result: default: False [4.31 / 20.00];
        R_UNDISC_RCPT(3.00)[];
        FORGED_RECIPIENTS(2.00)[m:,s:lin060501244@126.com,s:lin080203@163.com,s:lin10zhong@163.com,s:lin115peng@163.com,s:lin12.8@163.com,s:lin13532750916@163.com,s:lin13963@yahoo.com.cn,s:lin14@163.com,s:lin1595568@163.com,s:lin19357@126.com,s:lin19870118@163.com,s:lin19881231@126.com,s:lin1990214@163.com,s:lin19910710@yahoo.com.cn,s:lin1li2qiang3@163.com,s:lin2005000@163.com,s:lin2117050@tom.com,s:lin21654411@yahoo.cn,s:lin22062062@163.com,s:lin25611@163.com,s:lin2mp@yahoo.com.cn,s:lin313176186@163.com,s:lin3417441@163.com,s:lin5096@163.com,s:lin5201314cheng@163.com,s:lin529086183@163.com,s:lin535377889@163.com,s:lin54377@yahoo.cn,s:lin580aa@163.com,s:lin809809@qq.com,s:lin817700389@yahoo.com.cn,s:lin849@yahoo.cn,s:lin850621@163.com,s:lin860613@yahoo.com,s:lin8662344@yahoo.com.cn,s:lin8ai@qq.com,s:lin8kiss@163.com,s:lin919@126.com,s:lin96661@163.com,s:lin98@163.com,s:lin990605@163.com,s:lin9feng@163.com,s:lin@rekacekap.com,s:lin@ucolick.org,s:lin_cong@163.com,s:lin_dream@163.com,s:lin_hai
 _41@yahoo.com.cn,s:lin_hong@163.com,s:lin_hua_ping@163.com,s:lin_id@163.com,s:lin_jiang_690@eyou.com,s:lin_love_shi@126.com,s:lin_nil21@163.com,s:lin_sen1019@yahoo.com.cn,s:lin_siheng@126.com,s:lin_simin@sina.com,s:lin_wang765@163.com,s:lin_xing_sheng@hotmail.com,s:lin_z2991@sohu.com,s:lina.chan@chemsain.com,s:lina.finnstrom@hotmail.com,s:lina.kim@maec.es,s:lina.velvi@lycee-chateaubriand.eu,s:lina.weinreich@gmx.de,s:lina.yui@163.com,s:lina004@yahoo.cn,s:lina0309@163.com,s:lina1025830@tom.com,s:lina1982@yahoo.com.cn,s:lina200098@163.com,s:lina20971@yahoo.cn,s:lina320583@yahoo.cn,s:lina5546@yahoo.cn,s:lina624@163.com,s:lina6473@yahoo.com,s:lina6911@yahoo.cn,s:lina77403@yahoo.com,s:lina8705@163.com,s:lina_gustafsson@live.se,s:lina_jiao@163.com,s:linaa506@gmail.com,s:linaannisofi@hotmail.com,s:linaaz@126.com,s:linaborg-95@hotmail.com,s:linabury@gmail.com,s:linaertong@yahoo.cn,s:linagsci@hotmail.com,s:linaichao1314@163.com,s:linaimtv@yahoo.cn,s:linaiqin1984@yahoo.cn,s:linaissa88@hotmail.
 com,s:linaiziana@gmail.com,s:linajina@163.com,s:linalarsson93@hotmail.com,s:linalazi@163.com,s:linalina_hyxb@126.com,s:linan1001@yahoo.com.cn,s:linan321321@126.com,s:linan5566@sina.com];
        GENERIC_REPUTATION(-0.59)[-0.58797676028171];
        MIME_GOOD(-0.10)[text/plain];
        TAGGED_RCPT(0.00)[];
        FROM_EQ_ENVFROM(0.00)[];
        RCVD_COUNT_ZERO(0.00)[0];
        MIME_TRACE(0.00)[0:+];
        FROM_HAS_DN(0.00)[];
        FREEMAIL_ENVRCPT(0.00)[126.com,163.com,yahoo.com.cn,tom.com,yahoo.cn,qq.com,yahoo.com,sina.com,hotmail.com,sohu.com,gmx.de,live.se,gmail.com,bellsouth.net,21cn.com,freenet.de,yahoo.co.uk,sbcglobal.net,outlook.com,vip.qq.com,msn.com,hotmail.co.uk,vip.163.com,iinet.net.au,yahoo.com.tw,vip.sina.com,msn.cn,foxmail.com,mail.com,yeah.net,web.de,aol.com,china.com,mail.ru,bigpond.net.au,singnet.com.sg];
        TO_DN_ALL(0.00)[];
        MID_RHS_MATCH_FROM(0.00)[];
        RCPT_COUNT_ONE(0.00)[1];
        REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
        FREEMAIL_REPLYTO(0.00)[gmail.com];
        HAS_REPLYTO(0.00)[kmarion709@gmail.com]
X-Rspamd-Server: mail.heimpalkorhaz.hu
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

你好呀，

很抱歉打擾您並侵犯您的隱私。 我是單身，孤獨，需要一個關懷，愛心和浪漫的伴侶。

我是一個暗戀者，想探索更多了解彼此的機會。 我知道這樣聯繫你很奇怪，希望你能原諒我。 我是一個害羞的人，這是我知道我能引起你注意的唯一方式。 
我只是想知道你的想法，我的本意不是要冒犯你。 我希望我們能成為朋友，如果那是你想要的，儘管我希望不僅僅是朋友。 
我知道你有幾個問題要問，我希望我能用一些答案來滿足你的一些好奇心。

我相信“對於世界來說，你只是一個人，但對於特別的人來說，你就是全世界”這句話。 我想要的只是來自一個特殊伴侶的愛、浪漫的關懷和關注，我希望是你。

我希望這條消息將成為我們之間長期溝通的開始。 感謝您回复此消息，因為這會讓我很高興。


擁抱，

你的秘密崇拜者。

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87FB4B0A0A
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Feb 2022 10:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiBJJzt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Feb 2022 04:55:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiBJJzs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Feb 2022 04:55:48 -0500
X-Greylist: delayed 10584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 01:55:48 PST
Received: from antispam.sysnetpro.com.br (unknown [201.87.230.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93E3B08
        for <linux-rdma@vger.kernel.org>; Thu, 10 Feb 2022 01:55:48 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by antispam.sysnetpro.com.br (Postfix) with ESMTP id 4JvRz848J9zBwDN
        for <linux-rdma@vger.kernel.org>; Thu, 10 Feb 2022 04:43:32 -0200 (-02)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        encontresuafranquia.com.br; h=message-id:sensitivity:reply-to
        :date:date:from:from:subject:subject:content-description
        :content-transfer-encoding:mime-version:content-type
        :content-type:received:received:received:received:received
        :received:received; s=dkim; t=1644475405; x=1646289806; bh=qzHHY
        jL7hU1b4eqqx4Urz2P3r3LTP1eI+hMNkRI+mqE=; b=wyINeG1TmUvxu+r0rYo/e
        w9AD8Saolg2gIIfzfvUPH+YNGE/JxiiFxjbrnbdD1gFRU/YzjbDF9852FyKutonh
        fEPtURfaFC5iS+1/emm7/kz97hmUNz6I257UPJt7s82uI0civg3rO3MzvxIUWNx4
        TGQpQvQAcaVgTLr2bKvaBWbAQQCe0tYryMVyqA9cnoiM/doX/gYZ25kOG1EphYYD
        ntauGIbVnfoVXAQ5yPM+s8h6MAWO/WTJmkhH0Pxtn1s0KWjLOSUDarEU9Ughx+wb
        KSIyOi2DbZkcXeTMVRTC//+ctoaXV6YAnD5hvWeEDCRxydMm+dA7MWQOv49qOK0r
        A==
X-Amavis-Modified: Mail body modified (using disclaimer) -
        antispam.sysnetpro.com.br
X-Virus-Scanned: Scrollout F1 at sysnetpro.com.br
Received: from antispam.sysnetpro.com.br ([127.0.0.1])
        by localhost (antispam.sysnetpro.com.br [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id nzDs8btz2kzJ for <linux-rdma@vger.kernel.org>;
        Thu, 10 Feb 2022 04:43:25 -0200 (-02)
Received: from mx1.sysnetpro.email (unknown [10.0.3.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by antispam.sysnetpro.com.br (Postfix) with ESMTPS id 4JvH5k27DxzC8Hp
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 22:03:38 -0200 (-02)
Received: from localhost (localhost [127.0.0.1])
        by mx1.sysnetpro.email (Postfix) with ESMTP id 7245123FC70
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 21:03:19 -0300 (-03)
Received: from mx1.sysnetpro.email ([127.0.0.1])
        by localhost (mta3.sysnetpro.email [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id n1warY1Cr-em for <linux-rdma@vger.kernel.org>;
        Wed,  9 Feb 2022 21:03:19 -0300 (-03)
Received: from localhost (localhost [127.0.0.1])
        by mx1.sysnetpro.email (Postfix) with ESMTP id 5E3FC23FCFD
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 20:57:49 -0300 (-03)
X-Virus-Scanned: amavisd-new at mta3.sysnetpro.email
Received: from mx1.sysnetpro.email ([127.0.0.1])
        by localhost (mta3.sysnetpro.email [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N2JaJvTD_0_d for <linux-rdma@vger.kernel.org>;
        Wed,  9 Feb 2022 20:57:49 -0300 (-03)
Received: from [172.20.10.7] (unknown [105.112.59.18])
        by mx1.sysnetpro.email (Postfix) with ESMTPSA id 18F052A2BD0
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 20:53:40 -0300 (-03)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Business Proposal
To:     linux-rdma@vger.kernel.org
From:   david <tatiane.rocha@encontresuafranquia.com.br>
Date:   Wed, 09 Feb 2022 23:53:39 +0000
Reply-To: davidhilton711@gmail.com
X-Priority: 1 (High)
Sensitivity: Private
Message-Id: <20220209235341.18F052A2BD0@mx1.sysnetpro.email>
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

pozdravujem,


D=C3=BAfam, =C5=BEe tento e-mail dostanete vo velmi dobrom stave. Som p=C3=
=A1n David Hilton, ved=C3=BAci =C3=BActovn=C3=ADctva / auditu v Credit Suis=
se Bank, Cabot Square London, Spojen=C3=A9 kr=C3=A1lovstvo. Oslovil som V=
=C3=A1s v s=C3=BAvislosti s obchodn=C3=BDm n=C3=A1vrhom, ktor=C3=BD bude pr=
e n=C3=A1s a menej privilegovan=C3=BDch velk=C3=BDm pr=C3=ADnosom. Ako ved=
=C3=BAci =C3=BActovn=C3=ADctva / auditu region=C3=A1lnej kancel=C3=A1rie Gr=
eater London som objavil 15 800 000 libier (15 mili=C3=B3nov 8 000 libier) =
na =C3=BActe jedn=C3=A9ho z na=C5=A1ich zahranicn=C3=BDch z=C3=A1kazn=C3=AD=
kov, zosnul=C3=A9ho p=C3=A1na Manzoora Hassana. Bol obchodn=C3=BDm magn=C3=
=A1tom, ktor=C3=BD zahynul pri hav=C3=A1rii vrtuln=C3=ADka v roku 2014. P=
=C3=A1n Hassan mal 54 rokov, ked jeho man=C5=BEelka, jeho jedin=C3=BD syn A=
vraham (Albert) a jeho nevesta zahynuli pri hav=C3=A1rii vrtuln=C3=ADka.

Volba kontaktovat v=C3=A1s vyplynula z geografick=C3=A9ho charakteru miesta=
, kde =C5=BEijete, najm=C3=A4 z d=C3=B4vodu citlivosti transakcie a d=C3=B4=
vernosti tu poskytnut=C3=BDch inform=C3=A1ci=C3=AD. Na=C5=A1a banka teraz c=
ak=C3=A1, k=C3=BDm niekto z jej pr=C3=ADbuzn=C3=BDch po=C5=BEiada o dedicsk=
=C3=BD fond, no =C5=BEial, v=C5=A1etka n=C3=A1maha je zbytocn=C3=A1. Osobne=
 sa mi nepodarilo n=C3=A1jst pr=C3=ADbuzn=C3=BDch ani in=C3=BDch pr=C3=ADbu=
zn=C3=BDch p=C3=A1na Hassana. V tejto s=C3=BAvislosti v=C3=A1s =C5=BEiadam =
o s=C3=BAhlas, aby som v=C3=A1s predstavil ako bl=C3=ADzkeho pr=C3=ADbuzn=
=C3=A9ho/z=C3=A1vet zosnul=C3=A9ho, aby v=C3=A1m mohol byt vyplaten=C3=BD v=
=C3=BDta=C5=BEok z tohto =C3=BActu vo v=C3=BD=C5=A1ke 15,8 mili=C3=B3na =C2=
=A3.

Toto bude vyplaten=C3=A9 alebo rozdelen=C3=A9 v t=C3=BDchto percent=C3=A1ch=
 60 % mne a 40 % v=C3=A1m. V=C5=A1etky potrebn=C3=A9 pr=C3=A1vne dokumenty,=
 ktor=C3=BDmi je mo=C5=BEn=C3=A9 t=C3=BAto dedicsk=C3=BA pohlad=C3=A1vku z=
=C3=A1lohovat, nie je v=C3=B4bec probl=C3=A9m. Jedin=C3=A9, co mus=C3=ADm u=
robit, je nahrat va=C5=A1e men=C3=A1 do dokumentov a legalizovat ich na Naj=
vy=C5=A1=C5=A1om s=C3=BAde Spojen=C3=A9ho kr=C3=A1lovstva, aby som dok=C3=
=A1zal, =C5=BEe ste opr=C3=A1vnen=C3=BDm pr=C3=ADjemcom tohto fondu. V=C5=
=A1etko, o co teraz =C5=BEiadam, je va=C5=A1a =C3=BAprimn=C3=A1 spolupr=C3=
=A1ca, d=C3=B4vernost a d=C3=B4vera, aby sme mohli uskutocnit t=C3=BAto tra=
nsakciu. Garantujem V=C3=A1m 100% =C3=BAspe=C5=A1nost a to, =C5=BEe t=C3=A1=
to obchodn=C3=A1 transakcia prebehne v s=C3=BAlade so z=C3=A1konom.

Uvedte nasleduj=C3=BAce podrobnosti, preto=C5=BEe na ich dokoncenie m=C3=A1=
me 5 pracovn=C3=BDch dn=C3=AD:

1. Va=C5=A1e cel=C3=A9 meno
2. Telef=C3=B3nne c=C3=ADslo
3. Kontaktn=C3=A1 adresa

Po metodickom hladan=C3=AD som sa rozhodol oslovit V=C3=A1s v n=C3=A1deji, =
=C5=BEe V=C3=A1s tento n=C3=A1vrh zaujme. Po potvrden=C3=AD tejto spr=C3=A1=
vy a prejaven=C3=AD z=C3=A1ujmu V=C3=A1m poskytnem podrobn=C3=A9 inform=C3=
=A1cie.

V=C3=A1=C5=BEime si va=C5=A1e schv=C3=A1lenie tohto e-mailu a obchodn=C3=A9=
ho n=C3=A1vrhu.

Te=C5=A1=C3=ADm sa na skor=C3=BA odpoved.

S pozdravom
David Hilton.

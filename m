Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEF24A89D2
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Feb 2022 18:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352739AbiBCRVO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Feb 2022 12:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbiBCRVO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Feb 2022 12:21:14 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F6CC06173B
        for <linux-rdma@vger.kernel.org>; Thu,  3 Feb 2022 09:21:14 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id h7so4126700iof.3
        for <linux-rdma@vger.kernel.org>; Thu, 03 Feb 2022 09:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=VLUJVkHtiDVjnh0cllUK8cbQhBtjL1Sy34TnRnPctPA=;
        b=Fi1YVqTEFSAwg/Q9K6CgojrClKOOg30iOpLVeid/yHCPvIA6Dx7e0RJg7cUGgOdBFv
         OkianAdHcv5hdtEK5ilna3YTtPX7T6kGSXINDw1LHuIQxPdckVRZPox8U+YTMS+KAeov
         icSfjzMX7WqclhD3TuHpk7LOUmsn6tJHOBtxN1zXAYBV3SnLTjOUaSfKG5E0OwT3uRAS
         EEZbSc+n1aww7eESwCLZwr9F6E0jc3EMmtoY/moyvD+JFNKHdwoAQTWP9qTeu/C5m1Lu
         2A9lhP8YeG3y5iwi9KZhMm67RBG48hQwSgImVuKn4UonV5JcwU2raaTq8VXhHphjDuzl
         RZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=VLUJVkHtiDVjnh0cllUK8cbQhBtjL1Sy34TnRnPctPA=;
        b=1/fsLKodeG5/Q7ECyLLLb1LJqgZI119Ooac7B6ZVvm1zZo7KGlzWo8etnKIkH6JDGR
         yXF3VUwIZKfRxRtlBAetRZADmnO9M6VzF6POecST7/oG4XGVVBGnemWjJLlYTmEdd6+1
         og1afWZjaD48nTHGMsK3gvKuMXfskBvBBJb0zdFGJqUjTELYpB/UN0blUn2Bqfz4G+PI
         mQ3GzX4WFBqyUn5xvyJ4SppmaSw7SrZxRiW+dQcj6n3gwzJYVSD/0/7wcO8b8yxuUoag
         /pibYO6HQ4S4QL81udAeKI2C76l2ude5cAiGb5iafrIPCFQX/OwQzKMibIji4MpQY4Eg
         5M6g==
X-Gm-Message-State: AOAM532pb4BlmRbMVKKfljJF78tEwQdzQl7kddxgZZR+cYZ/FKBMIXZd
        meDkst/I6Y6pcbuJC+4HkksiUXJtLkG7LLJPE4o=
X-Google-Smtp-Source: ABdhPJw0FT5jobI66wACI9pVYHVzQgl0dJMYUss2ob0f5XvXhl6AQ4lfiEmG89E89bAmgmeznyTgeS2z7YLY5DGExGU=
X-Received: by 2002:a05:6602:15c8:: with SMTP id f8mr19094822iow.35.1643908872891;
 Thu, 03 Feb 2022 09:21:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6602:1651:0:0:0:0 with HTTP; Thu, 3 Feb 2022 09:21:12
 -0800 (PST)
Reply-To: jesspayne72@gmail.com
From:   Jess Payne <abdoulayesalle23@gmail.com>
Date:   Thu, 3 Feb 2022 09:21:12 -0800
Message-ID: <CAJbrH2CK1uQcY5C0oi5KBm=Qrj=cfu75JzpAOVYK8nUa9RgZrw@mail.gmail.com>
Subject: =?UTF-8?B?5oiR6ZyA6KaB5L2g55qE5biu5YqpL0kgbmVlZCB5b3VyIGFzc2lzdGFuY2Uu?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

5oiR5biM5pyb5L2g6IO955CG6Kej6L+Z5p2h5L+h5oGv77yM5Zug5Li65oiR5q2j5Zyo5L2/55So
57+76K+R57uZ5L2g5YaZ5L+h44CCDQoNCuaIkeaYr+adsOilv8K35L2p5oGp5Lit5aOr5aSr5Lq6
44CCDQoNCuWcqOe+juWbvemZhuWGm+eahOWGm+S6i+mDqOmXqOOAgue+juWbve+8jOS4gOWQjeS4
reWjq++8jDMyIOWyge+8jOaIkeWNlei6q++8jOadpeiHque+juWbveeUsOe6s+ilv+W3nuWFi+WI
qeWkq+WFsO+8jOebruWJjempu+aJjuWcqOWIqeavlOS6muePreWKoOilv++8jOS4juaBkOaAluS4
u+S5ieS9nOaImOOAguaIkeeahOWNleS9jeaYr+esrDTmiqTnkIbpmJ/nrKw3ODLml4XmlK/mj7To
kKXjgIINCg0K5oiR5piv5LiA5Liq5YWF5ruh54ix5b+D44CB6K+a5a6e5ZKM5rex5oOF55qE5Lq6
77yM5YW35pyJ6Imv5aW955qE5bm96buY5oSf77yM5oiR5Zac5qyi57uT6K+G5paw5pyL5Y+L5bm2
5LqG6Kej5LuW5Lus55qE55Sf5rS75pa55byP77yM5oiR5Zac5qyi55yL5Yiw5aSn5rW355qE5rOi
5rab5ZKM5bGx6ISJ55qE576O5Li95Lul5Y+K5aSn6Ieq54S25omA5oul5pyJ55qE5LiA5YiH5o+Q
5L6b44CC5b6I6auY5YW06IO95pu05aSa5Zyw5LqG6Kej5oKo77yM5oiR6K6k5Li65oiR5Lus5Y+v
5Lul5bu656uL6Imv5aW955qE5ZWG5Lia5Y+L6LCK44CCDQoNCuaIkeS4gOebtOW+iOS4jeW8gOW/
g++8jOWboOS4uuWHoOW5tOadpeeUn+a0u+WvueaIkeS4jeWFrOW5s++8m+aIkeWcqCAyMQ0K5bKB
5pe25aSx5Y675LqG54i25q+N44CC5oiR54i25Lqy55qE5ZCN5a2X5piv5biV54m56YeM5pav5L2p
5oGp5ZKM5oiR55qE5q+N5Lqy546b5Li95L2p5oGp44CC5rKh5pyJ5Lq65biu5Yqp5oiR77yM5L2G
5oiR5b6I6auY5YW05oiR57uI5LqO5Zyo576O5Yab5Lit5om+5Yiw5LqG6Ieq5bex44CCDQoNCuaI
kee7k+WpmueUn+S6huS4gOS4quWtqeWtkO+8jOS9huS7luWOu+S4luS6hu+8jOWcqOaIkeS4iOWk
q+W8gOWni+iDjOWPm+aIkeWQjuS4jeS5he+8jOaIkeS4jeW+l+S4jeaUvuW8g+WpmuWnu+OAgg0K
DQrmiJHkuZ/lvojlubjov5DlnKjmiJHnmoTlm73lrrbnvo7lm73lkozliKnmr5Tkuprnj63liqDo
pb/ov5nph4zmi6XmnInmiJHnlJ/mtLvkuK3pnIDopoHnmoTkuIDliIfvvIzkvYbmsqHmnInkurrn
u5nmiJHlu7rorq7jgILmiJHpnIDopoHkuIDkuKror5rlrp7nmoTkurrmnaXkv6Hku7vvvIzku5bk
uZ/kvJrlu7rorq7miJHlpoLkvZXmipXotYTmiJHnmoTpkrHjgILlm6DkuLrmiJHmmK/miJHniLbm
r43lnKjku5bku6zmrbvliY3nlJ/kuIvnmoTllK/kuIDkuIDkuKrlpbPlranjgIINCg0K5oiR5LiN
6K6k6K+G5L2g77yM5L2G5oiR6K6k5Li65pyJ5LiA5Liq5Y+v5Lul5L+h5Lu755qE5aW95Lq677yM
5Y+v5Lul5bu656uL55yf5q2j55qE5L+h5Lu75ZKM6Imv5aW955qE5ZWG5Lia5Y+L6LCK77yM5aaC
5p6c5L2g55yf55qE5pyJ5LiA5Liq6K+a5a6e55qE5ZCN5a2X77yM5oiR5Lmf5pyJ5LiA5Lqb5LqL
5oOF6KaB5ZKM5L2g5YiG5Lqr55u45L+h44CC5Zyo5L2g6Lqr5LiK77yM5Zug5Li65oiR6ZyA6KaB
5L2g55qE5biu5Yqp44CC5oiR5oul5pyJ5oiR5Zyo5Yip5q+U5Lqa54+t5Yqg6KW/6LWa5Yiw55qE
5oC76aKd77yINDcwDQrkuIfnvo7lhYPvvInjgILmiJHlsIblnKjkuIvkuIDlsIHnlLXlrZDpgq7k
u7bkuK3lkYror4nkvaDmiJHmmK/lpoLkvZXlgZrliLDnmoTvvIzkuI3opoHmg4rmhYzvvIzlroPk
u6zmmK/ml6Dpo47pmannmoTvvIzmiJHov5jlnKjkuI4gUmVkDQrmnInogZTns7vnmoTkurrpgZPk
uLvkuYnljLvnlJ/nmoTluK7liqnkuIvlsIbov5nnrJTpkrHlrZjlhaXkuobkuIDlrrbpk7booYzj
gILmiJHluIzmnJvkvaDku6XmiJHnmoTlj5fnm4rkurrouqvku73mjqXlj5fln7rph5HvvIzlubbl
nKjmiJHlnKjov5nph4zlrozmiJDlkI7lpqXlloTkv53nrqHlroPvvIzlubbojrflvpfmiJHnmoTl
hpvkuovpgJrooYzor4HvvIzku6Xkvr/lnKjkvaDnmoTlm73lrrbkuI7kvaDkvJrpnaLvvJvkuI3o
poHlrrPmgJXpk7booYzkvJrpgJrov4fnlLXmsYflsIbotYTph5Hovaznu5nmgqjvvIzov5nlr7nm
iJHku6zmnaXor7TlronlhajkuJTlv6vmjbfjgIINCg0K56yU6K6wO+aIkeS4jeefpemBk+aIkeS7
rOimgeWcqOi/memHjOW+heWkmuS5heWSjOaIkeeahOWRvei/kO+8jOWboOS4uuaIkeWcqOi/memH
jOW5uOWFjeS6juS4pOasoeeCuOW8ueiireWHu++8jOi/meWvvOiHtOaIkeWvu+aJvuS4gOS4quWA
vOW+l+S/oei1lueahOS6uuadpeW4ruWKqeaIkeaOpeaUtuWSjOaKlei1hOWfuumHke+8jOWboOS4
uuaIkeWwhuadpeWIsOS9oOeahOWbveWutuWHuui6q+aKlei1hO+8jOW8gOWni+aWsOeUn+a0u++8
jOS4jeWGjeW9k+WFteOAgg0KDQrlpoLmnpzmgqjmhL/mhI/osKjmhY7lpITnkIbvvIzor7flm57l
pI3miJHjgILmiJHkvJrlkYror4nkvaDmjqXkuIvmnaXnmoTmtYHnqIvvvIzlubbnu5nkvaDlj5Hp
gIHmm7TlpJrlhbPkuo7ln7rph5HlrZjlhaXpk7booYznmoTkv6Hmga/jgILku6Xlj4rpk7booYzl
sIblpoLkvZXluK7liqnmiJHku6zpgJrov4fnlLXmsYflsIbotYTph5Hovaznp7vliLDmgqjnmoTl
m73lrrbjgILoi6XmnInlhbTotqPor7fogZTns7vmnKzkurrjgIINCg==

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9514BA016
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 13:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbiBQM11 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 07:27:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiBQM11 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 07:27:27 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BAD13196E;
        Thu, 17 Feb 2022 04:27:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so6065057wme.1;
        Thu, 17 Feb 2022 04:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YwoTA54xmjCIC8opLl0t662jZXVbCfBYo/w5mihCHqI=;
        b=iD3yxhLP/ydeNAILAIWPlUsGoaluCSYRHGu3jNRm5f1OjumEsZs3Z8leJFsJjOG0Jn
         g9DNQHUJszpW9gFWpHmWqhoedKSQY75dexkdVGrPyp7s0MAwAlsLalvmlWFqKxfhHgSP
         T2vOOjKYjQ9Git5Pb51QQbNVHKrqIPAg0mAa2Cm+7jq0Ueozx/zeaHlgiobl2KkE1RlZ
         8SX29uJyMZwpsQ39Rcv65bprzCPyuNYBIkZ6C8Bgn6TixxhTmsCs1QbqqsN73y/OkF4+
         FLrWiB/jIiI6nOTjDEWnoyNlC4TknPcbKtU8v3MWhrdjTajV/ZVWWxPgkm7UwYt+xn/E
         Mwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwoTA54xmjCIC8opLl0t662jZXVbCfBYo/w5mihCHqI=;
        b=kyYeVc8Jb0K/s3tJzc8HuOa2Z10AqmA1ncsAS6iZarOauru55/cWVqzWIoMdVMOUN2
         qQhSxealX2T/euZ/l9CKr9ghe9OHwCfNBnFVSf04X8a3xdrO+E3ECP3CfUi3s1nx6PSe
         roJt265ukvd73DcB7K9bJLDpbcoFWC60eKZhvwRCJgs2nDb8X6z2PvSF++192xe244n6
         Z8uqrSJR3IievOJCKaiciyPaaiLBy7QgK8ahHaRaewAoSQzGTy80XfMv/a1TgC6P6isO
         y0dcAMlNAzjsaPkktafUX7gWAx9wYcg5FsIzUDBEyg2/4O6QHCeO+JWrM5cWnCEVRgp8
         b6fg==
X-Gm-Message-State: AOAM532/1KpjlD+dFk/tXXF7AxN5yEX+5EXls2wATaFmF9qPQGXIEev3
        UekSEv8keDeBMYAum4b5FGE=
X-Google-Smtp-Source: ABdhPJwI17iBbo333WU3PdwCdy45js7dQ1zvzJqRNVsGhd7dNHrynuBJ7fQFCdQNgtKeRdD3cMv5Zw==
X-Received: by 2002:a7b:cc8c:0:b0:37b:bf4b:3a35 with SMTP id p12-20020a7bcc8c000000b0037bbf4b3a35mr2529669wma.117.1645100831343;
        Thu, 17 Feb 2022 04:27:11 -0800 (PST)
Received: from leap.localnet (host-79-27-0-81.retail.telecomitalia.it. [79.27.0.81])
        by smtp.gmail.com with ESMTPSA id o4sm1260866wms.9.2022.02.17.04.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 04:27:10 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs@googlegroups.com
Cc:     Bart Van Assche <bvanassche@acm.org>,
        syzbot <syzbot+831661966588c802aae9@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [syzbot] possible deadlock in worker_thread
Date:   Thu, 17 Feb 2022 13:27:08 +0100
Message-ID: <4168398.ejJDZkT8p0@leap>
In-Reply-To: <YgnQGZWT/n3VAITX@slm.duckdns.org>
References: <0000000000005975a605d7aef05e@google.com> <2959649d-cfbc-bdf2-02ac-053b8e7af030@I-love.SAKURA.ne.jp> <YgnQGZWT/n3VAITX@slm.duckdns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On luned=C3=AC 14 febbraio 2022 04:44:25 CET Tejun Heo wrote:
> Hello,
>=20
> On Mon, Feb 14, 2022 at 10:08:00AM +0900, Tetsuo Handa wrote:
> > +	destroy_workqueue(srp_tl_err_wq);
> >=20
> > Then, we can call WARN_ON() if e.g. flush_workqueue() is called on syst=
em-wide workqueues.
>=20
> Yeah, this is the right thing to do. It makes no sense at all to call
> flush_workqueue() on the shared workqueues as the caller has no idea what
> it's gonna end up waiting for. It was on my todo list a long while ago but
> slipped through the crack. If anyone wanna take a stab at it (including
> scrubbing the existing users, of course), please be my guest.
>=20

Just to think and understand... what if the system-wide WQ were allocated a=
s unbound=20
ordered (i.e., as in alloc_ordered_workqueue()) with "max_active" of one?

1) Would it solve the locks dependency problem?
2) Would it introduce performance penalties (bottlenecks)?

Greetings,

=46abio

>
> Thanks.
>=20
> --=20
> tejun
>=20




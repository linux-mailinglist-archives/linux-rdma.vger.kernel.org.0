Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8346710F4BA
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2019 02:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfLCB5Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Dec 2019 20:57:25 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:41759 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfLCB5Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Dec 2019 20:57:25 -0500
Received: by mail-il1-f170.google.com with SMTP id q15so1648850ils.8
        for <linux-rdma@vger.kernel.org>; Mon, 02 Dec 2019 17:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5fm9WjIUCh0oGj+s2hCs1nSQVBbY/KUXsTXRFZUqJs=;
        b=EyFMpOYax1oiF0nSR+e2thFxICoEipITxssDjRTYfC7KhD6b7O8lxMp1dgNmBZIFnt
         Y9YMTTGEZCjeByMKBwgoAWSQGBvzJNuKVXXmxmZIqbhMu+Ubbt+9PhwDDHTS+xFjUG/f
         niPaR4BiQaQoVP1WfA4TYRnRptt4VB4o6LA7R4yZNtEZ5c+eblIgBI8dH8rOGAbRaDg1
         Mr26cBRIe0QJj7nvFlckqHlMW8tgo3E6lb3WeggT3N06NODyn4fZi7fcWTeGvy4vOgNN
         gen6aX/3ineYXg3JaVDQNgcKuvz91BYPIF6SQonDLDf2O7PvpOxxbiz9mQOcSIuwG0Kd
         3WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5fm9WjIUCh0oGj+s2hCs1nSQVBbY/KUXsTXRFZUqJs=;
        b=c10cDf9ROf/mAmUjOruiCTr5Su2Wh83s0+l9lCa4o43UE0RBoRjfyW8vhtpp8XiGZl
         DBpQGt3Jwl3J+XQHI2goKTfovshhHwVKe7dxLKt03Z0h4u/iHb3k2fA3m6rDWKfNdZ/U
         D3gX1ROUtkDyl0vgJ4Sgh+wxmUmD1eVBAR6yKDf2BLYef/kYxwKGdijXF/2JqqH/5oZT
         kMdti+dhGk9ZX7fBsMPU9AhkX4st6MMlR2HyC/IuYRoVibsVnGlueoKrVl3uiW5FNZ/o
         LsZL8jR1slJjh/ae84ZDaCC9FBB2Fo+aCPMjujCLyY82Ym8Gy52STYoLI0qZM/w4ir72
         opNA==
X-Gm-Message-State: APjAAAUeHUtLv6NLFaKvn3fCbxbc7gEs0/Y0wXVc2hb4HGrhJqDqlHTj
        B3xZ7MLzK4yBI2b+h5wzFbi4T5xGwzPSYYB6rnw=
X-Google-Smtp-Source: APXvYqxzifjhj2wEY9k9Oedz1kDp9ni/ptjsv+bkU+d8YVMZcDMSTTcoo6LLuAlaLn3Vt3tAgUXe1LOIE/MRplCKaM4=
X-Received: by 2002:a92:3a58:: with SMTP id h85mr2363654ila.245.1575338244778;
 Mon, 02 Dec 2019 17:57:24 -0800 (PST)
MIME-Version: 1.0
References: <53ed2e18-c58e-1e9c-55f8-60b14dfa2052@zju.edu.cn>
 <4433c97d-218a-294e-3c03-214e0ef1379f@acm.org> <20191127111008.GC10331@unreal>
 <CADmRdJfEr405W1+m=jYDYV=MZtk_0mEamUA7UXt6rKangnAC1g@mail.gmail.com> <8e8d9ecc-9406-11b3-242b-3a84f3702f79@acm.org>
In-Reply-To: <8e8d9ecc-9406-11b3-242b-3a84f3702f79@acm.org>
From:   Steve Wise <larrystevenwise@gmail.com>
Date:   Mon, 2 Dec 2019 19:57:13 -0600
Message-ID: <CADmRdJcQV3hOObZXSQMgJynmFyeWietWb2gffo3T0o5NBPOfNQ@mail.gmail.com>
Subject: Re: [question]can hard roce and soft roce communicate with each other?
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leon@kernel.org>, wangqi <3100102071@zju.edu.cn>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey Bart,

Well, as long as every implementation supports proper iCRC and RoCE
standards, I don't see how there could be a problem...

Let me send my patch out now...


On Mon, Dec 2, 2019 at 6:57 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 11/27/19 6:24 AM, Steve Wise wrote:
> > I've recently uncovered a bug in RXE that causes iCRC errors when
> > running between RXE and a correct RoCE implementation.  The bug is
> > that RXE is not including pad bytes in its iCRC calculations.  So if
> > the application payload is not 4B aligned then you'll hit this bug.
> > You can see this by running ib_write_bw, for example, between mlnx_ib
> > and rxe.
> >
> > works:  ib_write_bw -s 32 -n 5
> > fails: ib_write_bw -s 33 -n 5
> >
> > I'll post a patch this coming weekend hopefully.
>   Hi Steve,
>
> Will that patch support coexistence of softRoCE implementations that use
> different CRC calculation methods?
>
> Thanks,
>
> Bart.

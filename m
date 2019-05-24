Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C5B29ADD
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 17:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389507AbfEXPUL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 11:20:11 -0400
Received: from c.mx.filmlight.ltd.uk ([54.76.112.217]:35009 "EHLO
        c.mx.filmlight.ltd.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389428AbfEXPUL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 11:20:11 -0400
X-Greylist: delayed 535 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 May 2019 11:20:10 EDT
Received: from localhost (localhost [127.0.0.1])
        by omni.filmlight.ltd.uk (Postfix) with ESMTP id E84FD40000D9;
        Fri, 24 May 2019 16:11:14 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 omni.filmlight.ltd.uk E84FD40000D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=filmlight.ltd.uk;
        s=default; t=1558710674;
        bh=0Ug3SmMBjFHqgISSjAkOrPxbVWMmS3DdLx7SQNNyROg=;
        h=Cc:Subject:To:References:From:Date:In-Reply-To:From;
        b=wpXaBT074VJO3lUY2B3AqfKB/W8kA/0eApqSZ41aOSGqNLFXeF+yci3TFm4WhVp4H
         kV37VGx9Na/NLT5TmdU7mOXvKRov8tvnBDw7t4Am86QVyAKBCTZ3DDWsVdZoEArlfE
         1m3WIQhTP2Qa/l+lxluF+WXJkuQNf4b1SOeoeu50=
Received: from montana.filmlight.ltd.uk (envoy [62.7.83.226])
        (Authenticated sender: roger)
        by omni.filmlight.ltd.uk (Postfix) with ESMTPSA id AB169887FAA;
        Fri, 24 May 2019 16:11:14 +0100 (BST)
Cc:     roger@filmlight.ltd.uk, LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau@lists.freedesktop.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC][PATCH] kernel.h: Add generic roundup_64() macro
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190523100013.52a8d2a6@gandalf.local.home>
 <CAHk-=wg5HqJ2Kfgpub+tCWQ2_FiFwEW9H1Rm+an-BLGaGvDDXw@mail.gmail.com>
 <20190523112740.7167aba4@gandalf.local.home>
From:   Roger Willcocks <roger@filmlight.ltd.uk>
Message-ID: <e4e875f0-2aa5-89f4-f462-78bedb9c5cde@filmlight.ltd.uk>
Date:   Fri, 24 May 2019 16:11:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523112740.7167aba4@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 23/05/2019 16:27, Steven Rostedt wrote:
>
> I haven't yet tested this, but what about something like the following:
>
> ...perhaps forget about the constant check, and just force
> the power of two check:
>
> 							\
> 	if (!(__y & (__y >> 1))) {			\
> 		__x =3D round_up(x, y);			\
> 	} else {					\

You probably want

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(__y &=
 (__y - 1))

--

Roger



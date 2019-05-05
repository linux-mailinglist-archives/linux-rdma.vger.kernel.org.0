Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3AA1412B
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 18:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfEEQqV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 12:46:21 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45170 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfEEQqV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 May 2019 12:46:21 -0400
Received: by mail-yw1-f66.google.com with SMTP id w18so8559429ywa.12
        for <linux-rdma@vger.kernel.org>; Sun, 05 May 2019 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x0ZvxGqKqkQis3eWKYukVDy0+4WkHGdposYeRQupFOw=;
        b=xIVhJ3MLZE2ilPDUpTWGrclOXQUa5GWlZDrc3RalvMuJns3oV1XuBnemj2jSVzsB2i
         IaXaj4WAhc/5W6lLfkAlZkIfICx/0C64E6q7DFSEEu5gwNm2t493J415QXaJS/WXqqkg
         HAFVU39KEipINsnsZ4SWXyE9WgOKjVs2tnwVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x0ZvxGqKqkQis3eWKYukVDy0+4WkHGdposYeRQupFOw=;
        b=A++9YMJXD3GOYL0tJiKKJhAC/53gPx8d4iRfDB+1Z5ZWqUKakCYLWLhrKhJPwSIiGm
         aBbi7AzpBbDwg9qvl8EoojDDyGi7mvNWpBJucyM2K40cl9EvP1/4qASEnbunp9vRDipF
         ZeD1fSpb+DMpFcGznYxU8057RTEQMVxHviTR9RtG0o9URaANhlZyuebPkE1Qlyyen6Yx
         efs8+tus4bqxbXbdZE8i3vu93gogS9XWaXqUY9E2GeXSRDcisjg9yFZ5fe1WJ8a54huT
         rapkWqEDLEYsGBOLtgq45JYq2kCAqmmvyxJ5QUzTeM/LW8CqoulgzeZ7VQ1g2iysNIbd
         UQyQ==
X-Gm-Message-State: APjAAAUJepUiWf1Fjk8ZZjIor4G5KB7ESivgpqaor9FC2s8QsP2J/1dR
        5cSCvD5wce/+VZCqa4j5/7iXWw==
X-Google-Smtp-Source: APXvYqybXNSwDNcFaB8gd59q1/W0RHGbNpaxJftPOFeS7R/uocxtpki3475mBso+BoU9TxvSbEqMCw==
X-Received: by 2002:a81:9286:: with SMTP id j128mr13469693ywg.97.1557074780306;
        Sun, 05 May 2019 09:46:20 -0700 (PDT)
Received: from localhost (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id 202sm2517705ywt.72.2019.05.05.09.46.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 05 May 2019 09:46:19 -0700 (PDT)
Date:   Sun, 5 May 2019 12:46:19 -0400
From:   Chris Down <chris@chrisdown.name>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Kenny Ho <y2kenny@gmail.com>,
        "Welty, Brian" <brian.welty@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Parav Pandit <parav@mellanox.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org,
        J??r??me Glisse <jglisse@redhat.com>,
        dri-devel@lists.freedesktop.org, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Li Zefan <lizefan@huawei.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Christian K??nig <christian.koenig@amd.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        kenny.ho@amd.com, Harish.Kasiviswanathan@amd.com, daniel@ffwll.ch
Subject: Re: [RFC PATCH 0/5] cgroup support for GPU devices
Message-ID: <20190505164619.GA59027@chrisdown.name>
References: <20190501140438.9506-1-brian.welty@intel.com>
 <20190502083433.GP7676@mtr-leonro.mtl.com>
 <CAOWid-cYknxeTQvP9vQf3-i3Cpux+bs7uBs7_o-YMFjVCo19bg@mail.gmail.com>
 <bb001de0-e4e5-6b3f-7ced-9d0fb329635b@intel.com>
 <20190505071436.GD6938@mtr-leonro.mtl.com>
 <CAOWid-di8kcC2bYKq1KJo+rWfVjwQ13mcVRjaBjhFRzTO=c16Q@mail.gmail.com>
 <20190505160506.GF6938@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190505160506.GF6938@mtr-leonro.mtl.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Leon Romanovsky writes:
>First group (programmers) is using special API [1] through libibverbs [2]
>without any notion of cgroups or any limitations. Second group (sysadmins)
>is less interested in application specifics and for them "device memory" means
>"memory" and not "rdma, nic specific, internal memory".

I'd suggest otherwise, based on historic precedent -- sysadmins are typically 
very opinionated about operation of the memory subsystem (hence the endless 
discussions about swap, caching behaviour, etc).

Especially in this case, these types of memory operate fundamentally 
differently and have significantly different performance and availability 
characteristics. That's not something that can be trivially abstracted over 
without non-trivial drawbacks.

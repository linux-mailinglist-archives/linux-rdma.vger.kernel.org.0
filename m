Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7324216CB
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Oct 2021 20:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbhJDStK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Oct 2021 14:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbhJDStJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Oct 2021 14:49:09 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B851C061749
        for <linux-rdma@vger.kernel.org>; Mon,  4 Oct 2021 11:47:20 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 72so17506984qkk.7
        for <linux-rdma@vger.kernel.org>; Mon, 04 Oct 2021 11:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VIQyWDKjtm8zpbefAnobDdXF0doprXKLPKeg8daz4DY=;
        b=kJNJEdSXOo0W+mlnrGpXdwP5h0clLZYuJx4HQqD2lxexG5usTPHifCI+Yg0rfJThlS
         kVqzYcq/ar1qsNmvkNh1XR/yY5Ec1D5pSTp1QDwV0wUwq4GaXPFCSb53Y+r5+u73rn3b
         fpqkxppo5Ksn5+D9tMr3tubq9ykcIGXH9GBKTSxNhcB6xjw9RV7MehtxVqvqn2DRyiD1
         BhpoOMVf4okM6o8AaOLXYryRtSv2myb6V9z+EBEOmqwt6BGZTdHOYsBfEjemYx2R0Y64
         42QWs0z1uefWhbc/l5P4vaN1vIlwW9b9Ah5mSgPLEFABXiMA3Brrm6qrHWJy8ZFU9eYH
         YYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VIQyWDKjtm8zpbefAnobDdXF0doprXKLPKeg8daz4DY=;
        b=mR4lh6fp8whwh/NzYPciJQB8tzvxdH/ytgPa768vBksIk/tEuWcC4ul7BBbWEOlqub
         oy/gaunPmw4G1tWhLJyOlW56xETE8VCXYIXKa/2Y6o1d6PA4MWd+zqX/e86DEZ2Oqux0
         NnqpBVCTzFdWHfeAbTpls4/+Wb7vN2Noor+juUQeBswrajg1ToJvJprrb7yivZp7ZpMr
         9BZ+K/19hMt31JXu30e+Wy8DVg58a8DuiP0PY9qaaYoWjys2dpYjEsnrMSNysBF+ZKCT
         J+GGmyG93TiMIyQvrdLWh7GUV0i9z7ILEa1latLTOSyIP2A9i4wvBqJKlmxKJMEBV11B
         0qHA==
X-Gm-Message-State: AOAM531KbmxrLMJBVR87EGULGlenDWYZJecxMisduTPlFc4+YEw3whrj
        uQvOhO7aU7FBhGflz1OH3/+NzA==
X-Google-Smtp-Source: ABdhPJwcmTXNHabFe+XNKjUGGnLOTVckSM0DyjTcwlfFbRRr0I6OSQye+nSUyGRELAxA6cuj46J1ag==
X-Received: by 2002:ae9:ea19:: with SMTP id f25mr11392706qkg.341.1633373239774;
        Mon, 04 Oct 2021 11:47:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h17sm10023579qth.42.2021.10.04.11.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:47:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mXSze-00AZec-HI; Mon, 04 Oct 2021 15:47:18 -0300
Date:   Mon, 4 Oct 2021 15:47:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Jack Wang <xjtuwjp@gmail.com>,
        Md Haris Iqbal <haris.iqbal@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Subject: Re: [PATCH for-next 6/7] RDMA/rtrs: Do not allow sessname to contain
 special symbols / and .
Message-ID: <20211004184718.GD3544071@ziepe.ca>
References: <YVLEIVz1mCV0cZlC@unreal>
 <CAD+HZHW5u1MiB-+C784yYXZc9Q-F0yB+1EvRKb4sAQJe4p2Yeg@mail.gmail.com>
 <YVRWXim7T0mReBu/@unreal>
 <CAMGffE=mv8jJYeNC7BjiGbOt4qEFAQhXWROk4Uwzg5ED4a0sug@mail.gmail.com>
 <YVVgunT1hSIzu1tA@unreal>
 <CAMGffE=NP-iNcAQyVF57tbeJ1QcyMt7=savh=5BLxaC9TuAkTw@mail.gmail.com>
 <YVVtAFtOj0mPzSAR@unreal>
 <CAMGffEmYObHjk1Fk6jZqBnUPCE5o9=EpHHYqvevA8kKLjQG6aQ@mail.gmail.com>
 <YVchqF1oHf903+lk@unreal>
 <CAMGffEk4PJGkL3fufgKGUCmKDUqYOTFgKPisda0OeMN1hTk-iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEk4PJGkL3fufgKGUCmKDUqYOTFgKPisda0OeMN1hTk-iA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 04, 2021 at 07:41:08AM +0200, Jinpu Wang wrote:
> Sorry, I'm really not convinced, why should we only do allowing, not
> disabling in this case?
> 
> Jason, what's your suggestion?

At least from a correctness perspective only the characters / and \0
are forbidden, as well as any existing filenames like . and ..

Generally it is not a great idea to restrict things too much because
it can block the full use of UTF-8 for non-English languages.

However, I also think the sysfs in this driver is far too elaborate,
the time to complain was before this was all merged
unfortunately. Given that it is a simple enough bug fix it may as well
go ahead as-is.

Jason

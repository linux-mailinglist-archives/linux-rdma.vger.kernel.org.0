Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A42E22C7CF
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 16:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGXOUd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 10:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgGXOUc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jul 2020 10:20:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A7AC0619D3
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 07:20:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so5310263pjt.0
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ILYvzjV4vuYMnPwOfodeLEbLb6tZHzPdDa6+GVuYVH0=;
        b=CDo1WnYYK4UcdogDtcIfkot5N0TsISKScyArlYRx8iOJlqSUlWTHFw7odwDbz4wVi6
         alk5B9mDKP/ETLUBduqMB4fZCHkQsVpC83npgAcW72wKJhqccryFaqDtOZ/fMpS3WcVx
         B9vmHz90cTCiOHPdw1pZSPqlr/1FVYhUI9WAwIiNqF1jKvF9/ym7k1d0v9aVxLXVdyEl
         VgZBIK0ZxymReVjsw9lqoR6/OG5PGpEQGjOT0jgAh7KgEfrK6CMjp7I6bxNTMMU1A11k
         pqdKfnf/FfOmAHMyIHj7x7/O5opP85xRZdRv9WTogyiZfm7AhEah5W5huGmj8S52dYIo
         rYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ILYvzjV4vuYMnPwOfodeLEbLb6tZHzPdDa6+GVuYVH0=;
        b=C4KpG8RQUTJWabb58f2Mb7C8XffmLVvD4Miby7fu6vS2obcTlHzRhfQoA9D+fpU9Zf
         kbNeIfOKrWgard2SrJzA1a0c5SzIQ59eui3C+NEWX65iSEaUts7Oeze1xwMOwzwD96bq
         xy1//iBqHddPZD9IEZLQJy4HNyz8xQp0N7uEInEd+nPFa2ytkLZ5dtq6ULHAmTcplojb
         QFVpNEu2hIWimlCKXW5KT9+st45jTu1VRVR16r91nmvdc0eat7g568/QR+SLI2/MwVho
         NIkG/T9xexq1QSB2HGj8nb3sdUvOqBvZJQP0yjQHK4msfflvGC7KfFLcoy5rR3T/862E
         XTyA==
X-Gm-Message-State: AOAM53185ejhxB1nmbE019ZsEOrmiKmF+b0j6MmkRmcicOF/wczhsOYw
        PW8ZTGWNdIyBLkogAq808qHI6w==
X-Google-Smtp-Source: ABdhPJwIq5sZooxahRiycSUp7tLIFbc+Q5eIF/aj1Fn017DhxJKZpg15h67dACMdW8vZmO5otozsxA==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr8552320plo.108.1595600431605;
        Fri, 24 Jul 2020 07:20:31 -0700 (PDT)
Received: from [10.86.108.142] ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id b10sm6397059pft.59.2020.07.24.07.20.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 07:20:31 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [External] [PATCH] RDMA/rxe: fix retry forever when rnr_retry >=
 7
From:   Fan Yang <yangfan.fan@bytedance.com>
In-Reply-To: <20200724141844.GO25301@ziepe.ca>
Date:   Fri, 24 Jul 2020 22:20:27 +0800
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Zhu Yanjun <yanjunz@mellanox.com>, linux-rdma@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8FB57B18-229B-43B3-BD4C-DA47E4CFD0E0@bytedance.com>
References: <D1A472F9-6618-41A2-9CA8-B5231BD03D63@bytedance.com>
 <CAD=hENdG_0hdcRQk+sH6HyuOROM-U9_n2QahipgmOdESQDso3g@mail.gmail.com>
 <827596D2-8EB2-4660-9118-70289FCD09AA@bytedance.com>
 <20200724141844.GO25301@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> 
> Out of range values should be rejected at modify_qp time
> 

OK, I see.  Thank you all!

Fan


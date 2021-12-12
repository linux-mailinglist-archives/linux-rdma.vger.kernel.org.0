Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31188471801
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Dec 2021 04:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbhLLDbb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 11 Dec 2021 22:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhLLDba (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 11 Dec 2021 22:31:30 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7422EC061714
        for <linux-rdma@vger.kernel.org>; Sat, 11 Dec 2021 19:31:30 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r11so41118263edd.9
        for <linux-rdma@vger.kernel.org>; Sat, 11 Dec 2021 19:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=UrOW+rYPNT7AwPYOxWlOLy264eXRGPGUGnZTuq8z3kA=;
        b=PZ5ZyEV661aSDTFw4zJfOOoz1VzpR3mfbJyxDLmtcNGL/PuzG5/1h8qQgFpP5UrRKe
         lxAnjC8jzrRT1A/gSEWLQuWf8c1aQ9zrXpEg80lSEkxBCqHTUJfVQQEjbnP8Ue7hRdYv
         nydDPGWGzLiw7WEOkUruV+uJknm52mzcN86wcZDERhYudfPlISjFxs/dDuWGFpB+wEuj
         Z+K1eGTL1HJl+YdaLctj+ySLN6k0JH0JTOVIcdE4OV4jAWVzsNxv5AhZLPGiJrLPPfGL
         XDvCEdkxkYYD+ABVHfmLHYg9WN2W5N4lPUAxkJEYTznfYTX/pYIokdyubmc9WhZ74rMt
         Hdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UrOW+rYPNT7AwPYOxWlOLy264eXRGPGUGnZTuq8z3kA=;
        b=0U6xeinLDPSu+1yw6EhA1h4Q6+WbuSXz2W7L29mNCEwaWGjcD5l8nf7sUQRiWX/4UT
         Whd7JKcUd60pIjh02bObWL5HdthxYaddzw2GvrJiYd22E9M/zbxEDVnJyj+XWoCKzlwR
         OKabCbLcUk4XEKtpRoi1ZBckhiFJ/X/JT5xDxpnfrgMoepB2JUTHX7guDtgGzV8dsHBY
         LEVjHC8DYefjCAk3Rkcf+j6V7Lk90gUiErlHOZaDCsHBifEVP2Y/Fqk7rjCh4a5PuSz7
         +ed6NIXb0Cb8DoLFwk90PgwjHDhnOfnsXI4chyY2xHXA2Gd3VvW3JAS/ZjToA27b5wR3
         9D2w==
X-Gm-Message-State: AOAM531c47ujeZ8c0PGMjkdueeAVdcqAAPKNxb5do3ax12T4ajP82FZn
        fialmnXvhlNZiy3HC0XkgN9IPssSBz08LTTFYEDdp+TsxD4=
X-Google-Smtp-Source: ABdhPJxJx4Ka+kPFuozA45yt7NOANM63gkXIORbZ1xameCP9CQoItyO96PoJJ01vaJn/g2rGKEdkLUDiiZ6nZTqSkSE=
X-Received: by 2002:a17:906:2b12:: with SMTP id a18mr34705601ejg.254.1639279888934;
 Sat, 11 Dec 2021 19:31:28 -0800 (PST)
MIME-Version: 1.0
From:   Liu Yu <liuyu924@gmail.com>
Date:   Sun, 12 Dec 2021 11:31:18 +0800
Message-ID: <CA+yTbcnW-_XZbzysRHThyW5zAqjYNq9Ec_q6RytBVczLqbYfZw@mail.gmail.com>
Subject: 
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

subscribe linux-rdma

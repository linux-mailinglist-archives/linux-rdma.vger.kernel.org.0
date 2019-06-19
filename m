Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC9444C033
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 19:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfFSRsH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 13:48:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46988 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfFSRsH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 13:48:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id v9so53032pgr.13
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2019 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nq98yKg75hsyhBFG7qxMvdx6BEsFqlQ2oL275X6Ysew=;
        b=sHHMKRmAQ9MocPDyWQV3FsBI7N2hXgW9Z0aEdJl0gBDnvjybz2Ygzp5DQ/WNdeukis
         3qlVF5Opc3uiaAF5tbiTqwSdx8UFg4A0DVSqyprV08Fnm+i5ENhrE56OHbVSl56r6k/h
         DvRfSRST1ExPjL3KdWuVOKqNUyVNq5iE1vNQg2vT03pPiO2zoW8jgX2D5wjcTAF/xhlp
         mqx9VZGUjk2WsAUoD8d9qWgFlGMkL8e1LxPZzsbVRGKgSAlhuzjjIXbhK3KIXF38vMry
         hmZP08oaI2n4Xt7WsyBVa+d+/vLAzCvKL4dgwT68IC+Jgtwr071xXreLbodGLOUYy0wi
         HMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nq98yKg75hsyhBFG7qxMvdx6BEsFqlQ2oL275X6Ysew=;
        b=GUa3yLmoKe2bbj3Ee3g1s/X993uccbSjosobRTHMQzfQMB+KhIryMme4CabbJ6yNY1
         7mn5c0B6M+7z8ijIElpXXGYcxkbD+bI54BBtciZgY9fukvAVkFljz5iND9i6Q6tw2mI3
         LJVS7xtABRoCAaeTeQydfNJQYb2TGEWEomfLABBoAn5MzT8m8vB1jYT8yJg2nUn9vDoR
         Ri7rG6/Ab9dvRA75Hq/fb0xr2E8fZl7GDG9rIYJT1kux/3gFN+8LJ1oh4tIfbvu7sPkj
         XfT7rpT5mik++QNQF2rHEm8wsn3BBxOrA5IKgDmPRB3GYUhoIZB57rPxxVLOFPgu7Fit
         Zyzw==
X-Gm-Message-State: APjAAAU61DKW4mvgBfTTmFezfzHUQ0tAvB4Rpn6CV7mAuIn4Ev/mRxyc
        OwuMSXjOmIoagJxdjIs463y2qQ==
X-Google-Smtp-Source: APXvYqzvNWQ3H8jPHjCGZVl9lx5VJ5XiHlY4CPh3AYL0awGQ0Cg9miIsXXXXNG0taZ9S8GrXZcte8A==
X-Received: by 2002:a17:90a:fa12:: with SMTP id cm18mr12311816pjb.137.1560966486395;
        Wed, 19 Jun 2019 10:48:06 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id v9sm24715593pgj.69.2019.06.19.10.48.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 10:48:06 -0700 (PDT)
Date:   Wed, 19 Jun 2019 10:47:59 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Denis Kirjanov <kda@linux-powerpc.org>,
        David Ahern <dsahern@gmail.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        dledford@redhat.com, mkubecek@suse.cz
Subject: Re: [PATCH iproute2 v2 2/2] uapi: update if_link.h
Message-ID: <20190619104652.4c71c33b@hermes.lan>
In-Reply-To: <20190619141414.4242-2-dkirjanov@suse.com>
References: <20190619141414.4242-1-dkirjanov@suse.com>
        <20190619141414.4242-2-dkirjanov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 19 Jun 2019 16:14:14 +0200
Denis Kirjanov <kda@linux-powerpc.org> wrote:

> update if_link.h to commit 75345f888f700c4ab2448287e35d48c760b202e6
> ("ipoib: show VF broadcast address")
> 
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

This is only on net-next so the patches should target iproute2-next.

David can update from that.

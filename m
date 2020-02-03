Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC31151048
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 20:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgBCTaY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 14:30:24 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:39390 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCTaX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 14:30:23 -0500
Received: by mail-ed1-f49.google.com with SMTP id m13so17330094edb.6
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2020 11:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imatrex-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=NyrtzfXr+iaNtLunfMdTSxZnL8bO8cUBcVTls02xGKY=;
        b=icFS8W/rgR9UJr6spAj/O8pp0P/+63DIi0zObIjMptEEf2+zNV8ixOWVg/B8IE4hDe
         5+OAFfB69dXK/jnnTj1E6d+IiFRNQcKCHgrqotzmyXpdFWLp4M/GhvPtMEhHELsI+JdR
         0QXXRgedwPeASWGvwKHQXpuWWTFfkaOLPiMzRPLLP1+IyojXT6nafNzdjMPEmM4yTHn5
         R4lVvc9kNNTfRfD0Fzf1DuQzMOpzueO+pGfMVUzIcPPuEX6ljYqAWiiJH4a28H1JNrLS
         WhXTp+VlA+iaS6rgUgZyQNVrgvPB1HGZ4Qv8lQStoO7lVLyREe/LeIuvpiREWYDQ2kkU
         PF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NyrtzfXr+iaNtLunfMdTSxZnL8bO8cUBcVTls02xGKY=;
        b=kJcKVwf5Ux1pJ4TvYSBau5QxlTbRqu++Fi6pb8+DMwvClFsDTefH+DvXoXQ3WwX01I
         JHoJcPSr83nO0fLueW3jqiKYd7iSPJxR+li4wN0Gi2FiL/rV4FA2PcZ3I2p3DLaRUb66
         RPdrbns26WoThVtgEZfejK/4vAXB9SaO2gvTbrd0sIMxgsZO0WQfE0yJL3qc7Q/L03o2
         e4ZK2Wk210zdHnWM05to6wY8zdb6hH6CSmGVPO8Cjy0PLXcPiZVLuqzUZNrpM5zMCQpd
         6I6lm6SswJESq+VzuknctMoI3OH6sGVsxwghpdY8APR3bTxWy4K2HJcDQ8K/H4sBfEgj
         mLrw==
X-Gm-Message-State: APjAAAW26JZVjj/MKfPd3MRsQzSXiOjE0vGtDdUjayAa0j1tZjXr7LQp
        X/3v2StD4V5l9PXfD3ts1RLCXt7ywfC6oT6ZQaN2r91N
X-Google-Smtp-Source: APXvYqwVgnm7HJ63YXUDURYRV7CFI7p/6XHUdbSq2wKyc6F/wDnozxOn3tJGvenXGkdpzUcfvnh0CVEWos7NML6wSY4=
X-Received: by 2002:a50:9f8b:: with SMTP id c11mr13674925edf.165.1580758222368;
 Mon, 03 Feb 2020 11:30:22 -0800 (PST)
MIME-Version: 1.0
From:   Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Date:   Mon, 3 Feb 2020 11:30:09 -0800
Message-ID: <CAOc41xG5xb-6LEKmsvPPET9jKZ8ScAMW1rW=AzV1_HLs9DhNEQ@mail.gmail.com>
Subject: RDMA header inspection
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

I'm trying to inspect RDMA headers and they do not show up on
wireshark. How can I observe RDMA headers ? Also, any header parser
available in the code base that I can link to and use to process the
headers ?


Thank you.

Dimitris

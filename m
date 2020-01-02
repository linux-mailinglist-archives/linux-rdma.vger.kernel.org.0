Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52B4812E760
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 15:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgABOrS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 09:47:18 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:36065 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbgABOrS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 09:47:18 -0500
Received: by mail-wm1-f50.google.com with SMTP id p17so5859270wma.1
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jan 2020 06:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=photodiagnostic-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=2JWPdB3QJ73f3h4iVY70Nr+HqZV33Ph9JfKnmm6ogzc=;
        b=orfBV1Go1tb54efv2cfPE80211aWMj77lGtEEJoqqhLMapgrn7dJIh4HUuadQCRU9o
         uoIf8OYlR+DM2xWrfOuYpKM8rSud9TgCK/Ny+GP+6aRgeavzI3JfuwchaX+VCgTbQ5nc
         rRwcbvimLZ+6t5lN5CCLJOuXhIwd7PyaPP0ax05AL1gLv5gWtHQE8dn/DXjZd1FxuDuJ
         gqEAUJe1fq1Qu8hO69HqakM9zLEozO+vi//j43EetpSS21ALbjlo8GOTgrXuckNH0b75
         k/rm8q9xa3x38UbK6aDL5bR7a7KVIyjkOF8DeiI/glS97W0/nBOtDb6F3YosuwoSxQMi
         BIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2JWPdB3QJ73f3h4iVY70Nr+HqZV33Ph9JfKnmm6ogzc=;
        b=oe7OK+HKNEsyWADNq4XmbO1l7eAoLLzVHxIYIpXbwBid31AD0lfnFBD+L0ZqWtqT48
         HQD53VD6DxBUhBvq225IgWB+gQ4CSOlwC7zU+gaACq3G3xIFgmPylP1rgoR7LmgIm77t
         mnUHHH7REk/TPKG2oEk/XmME5UBCnCs68X5QqfgYDkGkScGjhCIgoc4ODS2um84ncaM2
         hzq1Wi0ISk1tFrU70eVJJEPrISjLnuN1yZpJBmoGlsXTx8hpeFSYR6nw8KKkDHri6gfb
         zHP+Ck8ldUBLwq0M8XAKUMpNvyN2bEIpNqmzyqRQG8mEdF9C6E2G72vuaf0efEQjq9lB
         v+8w==
X-Gm-Message-State: APjAAAVhcsglvXMCP7TKWkEMoKVyEw9PK5kArvK6TN3OMMB8lpi1j2lx
        KGWA6gJLdPhadBi6/JFrCXFLP2WdqG2u91Wdx9iTq735etSYtw==
X-Google-Smtp-Source: APXvYqzIV/Ikpo7/TE3h+wxIYPqal1lhtegT7jY+ezhQ9qAPY81wKdW4s1UPP3rT/4ivHscovLZKU5NIr0XZk5C4ZfA=
X-Received: by 2002:a7b:cd0a:: with SMTP id f10mr15284063wmj.56.1577976436948;
 Thu, 02 Jan 2020 06:47:16 -0800 (PST)
MIME-Version: 1.0
From:   Terry Toole <toole@photodiagnostic.com>
Date:   Thu, 2 Jan 2020 09:47:06 -0500
Message-ID: <CADw-U9BHcoHy3WJ8iSdYjAw3RxQf2vhkOKyL7k0yJdR3mP7Mug@mail.gmail.com>
Subject: Is it possible to transfer a large file between two computers using
 RDMA UD?
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,
Is it possible to transfer a large file, say 25GB, between two computers using
RDMA UD, and have an exact copy of the original file on the receiving side? My
understanding is that the order of the messages is not guaranteed with UD.
But I thought that if I only use one QP I could ensure that the ordering of the
data will be predictable.

This is a proof of concept at this time. My thought was to load the file into
memory on the client side and advance the address pointer after each
transfer.  The same scheme would be used on the receiving side. That is,
allocate a large region of memory and increment the address pointer
after each message is received.

I have been using the program ib_send_bw from perftest as a starting point.
After increasing the buffer size on the client side and advancing sg_list->addr
on the client side, I seem to be sending what I intend to send. At the present
time I am not yet advancing sg_list->addr on the server side.  When I print out
the first 100B of data after each transfer, I often see the data I
expect, but not
always.

The commands I've been using to launch my modified version of ib_send_bw are
client:
./ib_send_bw -R   -d mlx5_0 -c UD -i 1 -F -q 1 --mmap=myInputfile.dat
--report_gbits -n 1000 10.10.10.3

server:
./ib_send_bw -R -r 50 -d mlx5_0 -c UD -i 1 -q 1 -F -n 1000 --report_gbits

The "-n 1000" is just for debugging. It will be increased later.

Am I going about this in the correct way? Should I be able to copy a file using
RDMA UD? Any thoughts or suggestions would be most appreciated.

Thanks,

Terry

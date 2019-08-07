Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6844984300
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 05:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfHGDpd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 23:45:33 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:38668 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfHGDpd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 23:45:33 -0400
Received: by mail-vs1-f41.google.com with SMTP id k9so59742936vso.5
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2019 20:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=61ytXJsiXRoLTNE90MZ18mf6DS6YVqgHFlQmGhP5UoE=;
        b=txoxSlZYB9POrOcupTvnrRyG43czeWQV1yHIy6WdAyr7r1CN79q5chIwBAbT7No9gq
         DMAGlFOFwm5QurXcGDOdjiwk/oV+zfJ7xlxJphFvhKdLbW3cWwd0FgNJNJ9b1ciZ01io
         xA72U8DOcI/NMUzfikulcKHvyDhDvsko8KrJMixNR9TmxakYDkd4rh7v1mivnnqvmBPA
         MYXrEa5bMWF7EkdSCOrlBAb2/yDOYU8CABGDvJR64d8dPM/nxJxslS3aidAD7KzLMLX8
         ChPRV9zmzydvwEO1rRBO6w5vQvXlrYroFuIqScsdQCn7hVMxkDz8+eg/qiZni4blzxyx
         W8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=61ytXJsiXRoLTNE90MZ18mf6DS6YVqgHFlQmGhP5UoE=;
        b=M4iJPnx+0oqIF6HHKpnCbngr96mkKszCBG25WL8G/vWpywpKeOW2QowmaimNO5NzQj
         Tl4/nPer8S6qlg2ySPQieku4YHIndx/NpDNGp0s56AcYOYZvlXErlqhgGHHMqJEgivpL
         1Jq8AwJwwIna4ThmA69LPNfSSEqkfsm6HuqYHkEC0vuDldxwoTAHx9D5BgEAkzfmzbqY
         hVapGCxmYf1UAn9H1ZNXaU6Z0U8OAWfD3SB3y6sU1EIgwVMBkzM7ElA3d7FxOqBzZAW1
         YEE/WsmosUl9j5wTJ90OPJGMjVysoTsNXOBSevUuXMxY7jz+foK3wF80HPuj9xbOU66o
         olBQ==
X-Gm-Message-State: APjAAAXM5+sRWYOFSjfKPa7bMDuIm/+ZM5Rh+eT9049QlySyxDma0KPg
        th2m0Uslhkp9rL65/4i8bMFic905DoTdlZIGcdMK9pGn
X-Google-Smtp-Source: APXvYqyX0UOOjhz7wuJ3Hod9xQ6YoLzfdrPVpzanEHC1pi0M1HnHzfphM99DsP68etQy8OEOgGvv8yoj/edplV8slUU=
X-Received: by 2002:a67:c419:: with SMTP id c25mr4356900vsk.136.1565149532094;
 Tue, 06 Aug 2019 20:45:32 -0700 (PDT)
MIME-Version: 1.0
From:   James Harvey <jamespharvey20@gmail.com>
Date:   Tue, 6 Aug 2019 23:45:21 -0400
Message-ID: <CA+X5Wn75Lfh_i89sW1L+x1S3rnZsEGkzfNYju4woPvq0yCo=XA@mail.gmail.com>
Subject: v25.0 ninja install failure on pandoc-prebuilt using git tree or
 release tarball
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I'm one of the Arch Linux AUR repository rdma-core maintainers.

We've always build rdma-core from release tags in the git repo.

As-is, building v25 from the git repo has a new build requirement of
rst2man, which isn't documented in the release notes or in the readme.
(On Arch, part of the python-docutils package.)  I haven't directly
used pandoc or rst2man before, so I don't know if rst2man was added to
be an alternative to pandoc, or ran in addition to it.  In case they
were meant as alternatives, the build system doesn't currently
function that way.  With pandoc but without rst2man, it says
"'install' disabled", and never builds the man pages, causing "ninja
install" to fail from not finding
"pandoc-prebuilt/f48a8d31ddfa68fad6c3badbc768ac703976c43f".

I looked at switching to the release tarballs (rdma-core-25.0.tar.gz),
which of course has the prebuilt man pages.  I assume doing this
should completely prevent needing pandoc and rst2man.  But, then
"ninja install" fails from not finding
"pandoc-prebuilt/32acf8c8016edc90e7adedc5be9caecd9b8abb3e", which I do
see is not among the 81 directories in "pandoc-prebuilt/" in
"rdma-core-25.0.tar.gz".  Were some of the necessary prebuilt files
not included in the 25 tarball?
